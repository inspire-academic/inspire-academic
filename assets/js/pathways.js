// pathways.js — the shared list of GCSE pathway/route/tier presets shown
// in the teacher-facing "Pathway" field on teacher/teacher.html's Student
// Info panel (added 2026-09-09, profiles.pathway — supabase/student_pathway.sql).
//
// This is a UI convenience list, not a DB constraint: the field itself is
// free text (a teacher can type a pathway that isn't listed here and it
// still saves), so adding/removing a preset is just an edit to this file —
// no migration needed. Single source of truth so any other page that ever
// needs the same list (register.html, parent pages, assessment builders)
// reads this instead of hardcoding its own copy.
//
// Each entry: { value, group } — group is shown as the <option>'s label
// (e.g. via a <datalist> option's label attribute) so presets stay
// visually organised without needing separate dropdowns per category.
window.PATHWAY_OPTIONS = [
  { value: 'Combined Science: Trilogy', group: 'Science route' },
  { value: 'Combined Science: Synergy', group: 'Science route' },
  { value: 'Triple Science (Separate Sciences)', group: 'Science route' },

  { value: 'Combined Science Foundation Tier', group: 'Science tier' },
  { value: 'Combined Science Higher Tier', group: 'Science tier' },
  { value: 'Triple Science Foundation Tier', group: 'Science tier' },
  { value: 'Triple Science Higher Tier', group: 'Science tier' },

  { value: 'Foundation Tier Maths', group: 'Maths tier' },
  { value: 'Higher Tier Maths', group: 'Maths tier' },

  { value: 'AQA Level 2 Further Mathematics', group: 'Additional & advanced maths' },
  { value: 'OCR Level 3 Additional Mathematics', group: 'Additional & advanced maths' },

  { value: 'GCSE Statistics', group: 'Additional GCSE' },
  { value: 'GCSE Astronomy', group: 'Additional GCSE' }
]
