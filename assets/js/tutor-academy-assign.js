(function () {
  'use strict'

  const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
  const SUPABASE_ANON_KEY = 'sb_publishable_XxmrO4J18iyQ1Srub73BhQ_FBhd8mXR'
  const supa = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
  const U = window.TutorAcademyUI
  let session = null
  let profiles = []
  let programmes = []
  let enrollments = []
  let pendingRemoval = null

  const byId = id => document.getElementById(id)
  const esc = value => U.escHtml(value || '')
  const enrollmentKey = (profileId, programmeId) => `${profileId}:${programmeId}`

  function formatDate(value) {
    if (!value) return 'No deadline'
    const date = new Date(value)
    return Number.isNaN(date.getTime()) ? 'No deadline' : new Intl.DateTimeFormat('en-GB', { dateStyle: 'medium' }).format(date)
  }

  function dateInputValue(value) {
    if (!value) return ''
    const date = new Date(value)
    if (Number.isNaN(date.getTime())) return ''
    const local = new Date(date.getTime() - date.getTimezoneOffset() * 60000)
    return local.toISOString().slice(0, 10)
  }

  function programmeLabel(programme) {
    return `${programme.name}${programme.status === 'coming_soon' ? ' · Coming soon' : ''}`
  }

  async function api(method, body) {
    const response = await fetch('/api/v1/tutor-academy/assignments', {
      method,
      headers: {
        Authorization: `Bearer ${session.access_token}`,
        ...(body ? { 'Content-Type': 'application/json' } : {})
      },
      ...(body ? { body: JSON.stringify(body) } : {})
    })
    const payload = await response.json().catch(() => ({}))
    if (!response.ok || !payload.success) throw new Error(payload.error?.message || 'The assignment could not be updated.')
    return payload
  }

  async function checkAuth() {
    const { data: { session: current } } = await supa.auth.getSession()
    if (!current) { window.location.href = '/index.html'; return null }
    const { data: profile } = await supa.from('profiles').select('role').eq('id', current.user.id).maybeSingle()
    if (!profile || !['admin', 'super_admin'].includes(profile.role)) {
      window.location.href = '/teacher/tutor-academy/index.html'
      return null
    }
    byId('authLoading').hidden = true
    return current
  }

  function populateProgrammeFilter() {
    byId('programmeFilter').innerHTML = '<option value="">All programmes</option>' + programmes.map(programme =>
      `<option value="${esc(programme.id)}">${esc(programmeLabel(programme))}</option>`
    ).join('')
  }

  function enrollmentMap() {
    const map = new Map()
    enrollments.forEach(item => map.set(enrollmentKey(item.profile_id, item.programme_id), item))
    return map
  }

  function filteredProfiles() {
    const query = byId('tutorSearch').value.trim().toLowerCase()
    const programmeId = byId('programmeFilter').value
    const assignmentFilter = byId('assignmentFilter').value
    const map = enrollmentMap()
    return profiles.filter(profile => {
      const searchable = [profile.full_name, profile.role, profile.school_affiliation, ...(profile.subjects || [])].filter(Boolean).join(' ').toLowerCase()
      if (query && !searchable.includes(query)) return false
      const assignments = programmeId
        ? [map.get(enrollmentKey(profile.id, programmeId))].filter(Boolean)
        : enrollments.filter(item => item.profile_id === profile.id)
      if (assignmentFilter === 'assigned' && !assignments.length) return false
      if (assignmentFilter === 'unassigned' && assignments.length) return false
      return true
    })
  }

  function renderCard(profile, map) {
    const tutorAssignments = programmes.map(programme => ({
      programme,
      enrollment: map.get(enrollmentKey(profile.id, programme.id))
    }))
    const initials = (profile.full_name || 'Tutor').split(/\s+/).slice(0, 2).map(part => part[0]).join('').toUpperCase()
    return `<article class="ta-tutor-assignment-card" data-profile-id="${esc(profile.id)}">
      <header class="ta-tutor-card-head">
        <span class="ta-tutor-avatar" aria-hidden="true">${esc(initials)}</span>
        <div>
          <h2>${esc(profile.full_name || `Tutor · ${profile.id.slice(-8)}`)}</h2>
          <p>${esc(profile.role.replace('_', ' '))}${profile.school_affiliation ? ` · ${esc(profile.school_affiliation)}` : ''}</p>
        </div>
      </header>
      <div class="ta-programme-assignments">
        ${tutorAssignments.map(({ programme, enrollment }) => `
          <section class="ta-programme-assignment ${enrollment ? 'is-assigned' : ''}">
            <div class="ta-programme-assignment-copy">
              <div class="ta-programme-name">${esc(programme.name)}</div>
              <div class="ta-programme-meta">${enrollment ? `${esc(enrollment.status.replaceAll('_', ' '))} · ${esc(formatDate(enrollment.deadline))}` : programme.status === 'coming_soon' ? 'Available for advance assignment' : 'Not assigned'}</div>
            </div>
            <div class="ta-assignment-actions">
              <label for="deadline-${esc(profile.id)}-${esc(programme.id)}">
                <span class="sr-only">Deadline for ${esc(programme.name)}</span>
                <input type="date" id="deadline-${esc(profile.id)}-${esc(programme.id)}" value="${esc(dateInputValue(enrollment?.deadline))}">
              </label>
              <button class="btn btn-gold ta-assign-btn" type="button" data-action="assign" data-profile="${esc(profile.id)}" data-programme="${esc(programme.id)}">${enrollment ? 'Save deadline' : 'Assign'}</button>
              ${enrollment ? `<button class="btn btn-outline ta-remove-btn" type="button" data-action="remove" data-profile="${esc(profile.id)}" data-programme="${esc(programme.id)}">Remove</button>` : ''}
            </div>
            <div class="ta-row-status" id="status-${esc(profile.id)}-${esc(programme.id)}" role="status" aria-live="polite"></div>
          </section>`).join('')}
      </div>
    </article>`
  }

  function render() {
    const visible = filteredProfiles()
    const map = enrollmentMap()
    const assignedTutors = new Set(enrollments.map(item => item.profile_id)).size
    byId('assignmentSummary').innerHTML = `<strong>${profiles.length}</strong> tutors <span>·</span> <strong>${assignedTutors}</strong> assigned`
    byId('pageStatus').textContent = visible.length ? `${visible.length} tutor${visible.length === 1 ? '' : 's'} shown` : 'No tutors match these filters.'
    byId('tutorGrid').innerHTML = visible.map(profile => renderCard(profile, map)).join('')
  }

  async function load() {
    try {
      const payload = await api('GET')
      profiles = payload.profiles || []
      programmes = payload.programmes || []
      enrollments = payload.enrollments || []
      populateProgrammeFilter()
      render()
    } catch (error) {
      byId('pageStatus').textContent = error.message
      byId('pageStatus').classList.add('ta-error')
    }
  }

  async function assign(profileId, programmeId, button) {
    const status = byId(`status-${profileId}-${programmeId}`)
    const deadlineValue = byId(`deadline-${profileId}-${programmeId}`).value
    button.disabled = true
    status.textContent = 'Saving…'
    try {
      const deadline = deadlineValue ? new Date(`${deadlineValue}T23:59:59`).toISOString() : null
      const payload = await api('POST', { profileId, programmeId, deadline })
      const index = enrollments.findIndex(item => item.profile_id === profileId && item.programme_id === programmeId)
      if (index >= 0) enrollments[index] = payload.enrollment
      else enrollments.push(payload.enrollment)
      render()
      byId(`status-${profileId}-${programmeId}`).textContent = 'Assignment saved.'
    } catch (error) {
      status.textContent = error.message
      status.classList.add('ta-error')
      button.disabled = false
    }
  }

  function openRemoval(profileId, programmeId) {
    const profile = profiles.find(item => item.id === profileId)
    const programme = programmes.find(item => item.id === programmeId)
    pendingRemoval = { profileId, programmeId }
    byId('removeDialogText').textContent = `Remove ${programme?.name || 'this pathway'} from ${profile?.full_name || 'this tutor'}?`
    byId('removeDialog').showModal()
  }

  async function removePending() {
    if (!pendingRemoval) return
    const { profileId, programmeId } = pendingRemoval
    const status = byId(`status-${profileId}-${programmeId}`)
    status.textContent = 'Removing…'
    try {
      await api('DELETE', { profileId, programmeId })
      enrollments = enrollments.filter(item => !(item.profile_id === profileId && item.programme_id === programmeId))
      pendingRemoval = null
      render()
    } catch (error) {
      status.textContent = error.message
      status.classList.add('ta-error')
      pendingRemoval = null
    }
  }

  byId('tutorSearch').addEventListener('input', render)
  byId('programmeFilter').addEventListener('change', render)
  byId('assignmentFilter').addEventListener('change', render)
  byId('tutorGrid').addEventListener('click', event => {
    const button = event.target.closest('button[data-action]')
    if (!button) return
    if (button.dataset.action === 'assign') assign(button.dataset.profile, button.dataset.programme, button)
    if (button.dataset.action === 'remove') openRemoval(button.dataset.profile, button.dataset.programme)
  })
  byId('removeDialog').addEventListener('close', () => {
    if (byId('removeDialog').returnValue === 'confirm') removePending()
    else pendingRemoval = null
  })

  ;(async () => {
    session = await checkAuth()
    if (session) load()
  })()
})()
