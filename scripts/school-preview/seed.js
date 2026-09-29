// Fake data for the local School V1 preview (scripts/school-preview/server.js).
// Every person here is invented and labelled PREVIEW. The questions are the
// real concept-pack items in the repo, marked approved ONLY inside this
// in-memory preview so the pages have something to serve.
const fs = require('fs');
const path = require('path');

const USERS = {
  teacher: { id: 'f0000000-0000-4000-8000-000000000001', token: 'preview-teacher', label: 'Teacher' },
  ama: { id: 'f0000000-0000-4000-8000-0000000000a1', token: 'preview-ama', label: 'Pupil Ama' },
  kofi: { id: 'f0000000-0000-4000-8000-0000000000a2', token: 'preview-kofi', label: 'Pupil Kofi' },
  esi: { id: 'f0000000-0000-4000-8000-0000000000a3', token: 'preview-esi', label: 'Pupil Esi' }
};
const COHORT = 'c0000000-0000-4000-8000-000000000001';
const KEYS = ['a', 'b', 'c', 'd'];
const TOPIC = {
  'phy.energy.kinetic': 'Kinetic Energy', 'phy.energy.gravitational': 'Gravitational Potential Energy',
  'phy.energy.power': 'Power', 'phy.energy.elastic': 'Elastic Potential Energy'
};

function seed() {
  const packsDir = path.join(__dirname, '..', '..', 'curriculum', 'physics', 'packs');
  const questions = [], tags = [], options = [];
  let id = 9000;
  for (const f of fs.readdirSync(packsDir).filter(f => f.endsWith('.js'))) {
    const pack = require(path.join(packsDir, f));
    for (const x of pack.items) {
      const numeric = x.format === 'numeric';
      const o = x.options || {};
      const row = {
        id, subject: 'Physics', exam_board: 'Universal', level: 'GCSE', tier: x.tier, topic: 'Energy Stores & Transfers',
        subtopic: TOPIC[x.primary_concept] || 'Energy', difficulty: x.difficulty_band + 1, question_text: x.question_text,
        option_a: o.a || null, option_b: o.b || null, option_c: o.c || null, option_d: o.d || null, option_e: 'Not sure',
        correct_answer: numeric ? null : x.key, explanation: x.explanation, validated: true, active: true,
        review_status: 'approved', question_type: numeric ? 'numeric' : 'mcq', answer_spec: numeric ? x.answer : null,
        combined_eligible: true, evidence_class: x.evidence_class, block_id: pack.id, updated_at: '2026-09-29T00:00:00Z',
        diagram_spec: null, specification_ref: null
      };
      KEYS.forEach(k => { row['misconception_' + k] = numeric || k === x.key ? null : (x.feedback || {})[k] || null; });
      questions.push(row);
      tags.push({ item_source: 'diagnostic', item_id: String(id), concept_id: x.primary_concept, role: 'primary', evidence_class: x.evidence_class,
                  difficulty_band: x.difficulty_band, format: x.format, context_tags: x.context_tags || [] });
      for (const [opt, m] of Object.entries(x.misconception_map || {})) {
        options.push({ item_source: 'diagnostic', item_id: String(id), option: String(opt),
                       misconception_id: /^MIS-/.test(m) ? m : null, slip: /^MIS-/.test(m) ? null : m });
      }
      id++;
    }
  }
  const day = n => new Date(Date.now() - n * 86400000).toISOString().slice(0, 10);
  return {
    diagnostic_questions: questions, item_concepts: tags, item_option_misconceptions: options,
    profiles: [
      { id: USERS.teacher.id, role: 'teacher', first_name: 'Preview', last_name: 'Teacher', full_name: 'Preview Teacher' },
      { id: USERS.ama.id, role: 'student', first_name: 'Ama', last_name: '(preview)' },
      { id: USERS.kofi.id, role: 'student', first_name: 'Kofi', last_name: '(preview)' },
      { id: USERS.esi.id, role: 'student', first_name: 'Esi', last_name: '(preview)' }
    ],
    cohorts: [{ id: COHORT, teacher_id: USERS.teacher.id, name: 'PREVIEW group (fake pupils)' }],
    cohort_members: ['ama', 'kofi', 'esi'].map(k => ({ cohort_id: COHORT, student_id: USERS[k].id })),
    programme_cohorts: [], intervention_decisions: [],
    class_sessions: [{ id: 'pcs1', subject: 'Physics', session_date: day(10) }, { id: 'pcs2', subject: 'Physics', session_date: day(8) }],
    attendance_records: [
      { session_id: 'pcs1', student_id: USERS.ama.id, status: 'present' }, { session_id: 'pcs2', student_id: USERS.ama.id, status: 'present' },
      { session_id: 'pcs1', student_id: USERS.kofi.id, status: 'late' }, { session_id: 'pcs2', student_id: USERS.kofi.id, status: 'absent' },
      { session_id: 'pcs1', student_id: USERS.esi.id, status: 'present' }, { session_id: 'pcs2', student_id: USERS.esi.id, status: 'present' }
    ]
  };
}

module.exports = { seed, USERS, COHORT };
