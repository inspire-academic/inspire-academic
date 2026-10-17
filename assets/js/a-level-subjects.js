// The A-level subjects, and which of them a student takes.
//
// One line per subject in SUBJECTS: adding Biology or Maths is a new line
// here, nothing else. `slug` is the same key everywhere: the subjects row
// (subjects.slug), the content folders (curriculum/flashcards/<slug>/) and
// the student's choice in profiles.a_level_subjects.
//
// profiles.a_level_subjects (supabase/profiles_a_level_subjects.sql) maps
// each subject a student takes to their board for it, since a student can
// sit AQA in one subject and Edexcel in another:
//   { "physics-a-level": "aqa", "chemistry-a-level": "edexcel" }
// A subject whose board is not given falls back to profiles.exam_board.
//
// Used by dashboard.html and the flashcard app (assets/js/fc-app.js).
(function (root) {
  var SUBJECTS = [
    { slug: 'physics-a-level', name: 'Physics', icon: '⚡', page: '/a-level/physics' },
    { slug: 'chemistry-a-level', name: 'Chemistry', icon: '🧪', page: null }
  ];
  var BOARDS = { aqa: 'AQA', edexcel: 'Edexcel' };

  function bySlug(slug) {
    for (var i = 0; i < SUBJECTS.length; i++) if (SUBJECTS[i].slug === slug) return SUBJECTS[i];
    return null;
  }

  function boardOf(value) {
    var b = String(value || '').toLowerCase();
    return BOARDS[b] ? b : null;
  }

  // The subjects a profile says the student takes, in SUBJECTS order, each
  // with its board (or null if neither the subject nor the profile says).
  // An empty list means the student has not said.
  function mine(profile) {
    var chosen = (profile && profile.a_level_subjects) || {};
    if (typeof chosen !== 'object' || Array.isArray(chosen)) return [];
    var fallback = boardOf(profile.exam_board);
    return SUBJECTS.filter(function (s) { return Object.prototype.hasOwnProperty.call(chosen, s.slug); })
      .map(function (s) { return { slug: s.slug, name: s.name, icon: s.icon, page: s.page, board: boardOf(chosen[s.slug]) || fallback }; });
  }

  var api = { SUBJECTS: SUBJECTS, BOARDS: BOARDS, bySlug: bySlug, boardOf: boardOf, mine: mine };
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.IAALevel = api;
})(this);
