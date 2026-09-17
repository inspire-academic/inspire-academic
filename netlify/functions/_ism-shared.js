// Shared helpers for the ISM Class Netlify functions
// (ism-lesson-*.js, ism-response-save.js, ism-review-save.js,
// ism-submissions-list.js). Mirrors the request()/reply() shape
// already established in ism-pipeline-save.js and the
// verifyUser()/service-role posture from _ai-usage-guard.js /
// student-info.js — nothing new invented here.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const STAFF_ROLES = ['teacher', 'teacher_manager', 'admin', 'super_admin']
const ADMIN_ROLES = ['admin', 'super_admin']

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

// REST (PostgREST) requests — service role only, callers must enforce
// their own authorization before calling this (RLS is bypassed).
async function sb(path, serviceKey, options = {}) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...options,
    headers: {
      apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
      ...(options.body ? { 'Content-Type': 'application/json' } : {}),
      ...(options.headers || {})
    }
  })
  if (!response.ok) throw new Error(`Supabase REST ${path} failed (${response.status}): ${await response.text()}`)
  if (response.status === 204) return []
  return response.json()
}

async function sbRpc(fn, args, serviceKey) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/rpc/${fn}`, {
    method: 'POST',
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(args)
  })
  if (!response.ok) throw new Error(`Supabase RPC ${fn} failed (${response.status}): ${await response.text()}`)
  return response.json()
}

// Storage — private bucket, service role only.
async function storageUpload(bucket, path, contentType, body, serviceKey) {
  const response = await fetch(`${SUPABASE_URL}/storage/v1/object/${bucket}/${encodeURIComponent(path).replace(/%2F/g, '/')}`, {
    method: 'POST',
    headers: {
      apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
      'Content-Type': contentType, 'x-upsert': 'true'
    },
    body
  })
  if (!response.ok) throw new Error(`Storage upload ${bucket}/${path} failed (${response.status}): ${await response.text()}`)
  return response
}

async function storageDownload(bucket, path, serviceKey) {
  const response = await fetch(`${SUPABASE_URL}/storage/v1/object/${bucket}/${encodeURIComponent(path).replace(/%2F/g, '/')}`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!response.ok) throw new Error(`Storage download ${bucket}/${path} failed (${response.status}): ${await response.text()}`)
  return response.text()
}

async function getRole(userId, serviceKey) {
  const rows = await sb(`profiles?id=eq.${encodeURIComponent(userId)}&select=role`, serviceKey)
  return rows[0] && rows[0].role
}

// A lesson is owned by whoever created it; admins bypass ownership —
// same shape as every other staff-scoped function in this codebase.
async function ownsLesson(lessonId, userId, callerRole, serviceKey) {
  if (ADMIN_ROLES.includes(callerRole)) return true
  const rows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lessonId)}&select=created_by`, serviceKey)
  return rows[0] && rows[0].created_by === userId
}

// Every data-save="..." id found in a lesson's HTML — used both to
// validate an upload (must contain at least one) and to record a
// field_manifest for admin visibility.
function extractFieldManifest(html) {
  const ids = new Set()
  const re = /data-save\s*=\s*"([^"]+)"/g
  let m
  while ((m = re.exec(html))) ids.add(m[1])
  return Array.from(ids)
}

module.exports = {
  SUPABASE_URL, STAFF_ROLES, ADMIN_ROLES, CORS,
  reply, sb, sbRpc, storageUpload, storageDownload,
  getRole, ownsLesson, extractFieldManifest, verifyUser
}
