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
// Each subject's page (assets/js/a-level-subject.js) can group its topics:
//   sections: [{ title, topics: [topic slug, ...] }]   headed groups, in order
//   options:  { board, topics, compulsoryFor }        topics a student of that
//             board sits only one of; compulsoryFor names, per other board,
//             the ones that are ordinary topics there and hides the rest
// Topic slugs are the topics rows' slugs (al-<subject>-<file name>).
//
// Used by dashboard.html, the flashcard app (assets/js/fc-app.js) and the
// A-level subject pages.
(function (root) {
  var SUBJECTS = [
    { slug: 'physics-a-level', name: 'Physics', icon: '⚡', page: '/a-level/physics',
      options: { board: 'aqa',
        topics: ['al-physics-astrophysics', 'al-physics-medical-physics', 'al-physics-engineering-physics', 'al-physics-turning-points', 'al-physics-electronics'],
        compulsoryFor: { edexcel: ['al-physics-astrophysics'] } } },
    { slug: 'chemistry-a-level', name: 'Chemistry', icon: '🧪', page: '/a-level/chemistry',
      sections: [
        { title: 'Physical chemistry', topics: ['atomic-structure', 'amount-of-substance', 'bonding', 'energetics', 'kinetics', 'equilibria', 'redox',
          'thermodynamics', 'rate-equations', 'electrode-potentials', 'acids-and-bases'].map(function (t) { return 'al-chemistry-' + t; }) },
        { title: 'Inorganic chemistry', topics: ['periodicity', 'group-2', 'halogens', 'transition-metals', 'ions-in-solution'].map(function (t) { return 'al-chemistry-' + t; }) },
        { title: 'Organic chemistry', topics: ['organic-intro', 'alkanes', 'halogenoalkanes', 'alkenes', 'alcohols', 'organic-analysis', 'optical-isomerism', 'carbonyls',
          'carboxylic-acids', 'aromatic', 'amines', 'polymers', 'amino-acids-dna', 'organic-synthesis', 'nmr-chromatography'].map(function (t) { return 'al-chemistry-' + t; }) }
      ] }
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
