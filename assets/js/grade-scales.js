// grade-scales.js — pluggable grade scale definitions (single source of truth)
// CurriculumSystem -> { values, direction, normReferenced, passGrade, passLabel }
// Consumed by student/report-results.html. Grading is not portable across
// curriculum systems (GCSE 9-1 vs. WASSCE A1-F9 run in opposite directions,
// and WASSCE has no published mark boundaries) — each system reads its own
// scale here rather than any page assuming a 9-1 shape.
window.GRADE_SCALES = {
  'gcse-uk': {
    values: ['9','8','7','6','5','4','3','2','1','U'],
    direction: 'higher-better',
    normReferenced: false,
    passGrade: '4',
    passLabel: 'Grade 4 (Standard Pass)'
  }
};
