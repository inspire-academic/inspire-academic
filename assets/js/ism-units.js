// ISM Class: Subject → Unit → Lesson grouping, shared by
// ism-class/index.html (progress summary per subject) and
// ism-class/subject.html (the unit list). See supabase/ism_units.sql.
(function () {
  // A lesson counts as done once the student has handed it in.
  const DONE_STATUSES = ['submitted', 'reviewed'];

  // Labels for ism_student_lesson_progress.status (pill styles in
  // assets/css/ism-search.css).
  const STATUS_LABEL = {
    not_started: 'Not Started', in_progress: 'In Progress',
    submitted: 'Submitted', reviewed: 'Reviewed', returned: 'Returned'
  };

  // Units in unit_number order, lessons by lesson_number within each (week
  // as the tie-break). Lessons not yet filed under a unit go last. Each
  // lesson gets displayNumber: its lesson_number, or its position if unset.
  function groupIntoUnits(lessons, units) {
    const byId = Object.fromEntries(units.map(u => [u.id, { unit: u, lessons: [] }]));
    const loose = { unit: null, lessons: [] };
    lessons.forEach(l => (byId[l.unit_id] || loose).lessons.push(l));
    const groups = Object.values(byId).sort((a, b) => a.unit.unit_number - b.unit.unit_number);
    if (loose.lessons.length) groups.push(loose);
    const num = v => (v == null ? Infinity : v);
    return groups.filter(g => g.lessons.length).map(g => {
      g.lessons.sort((a, b) => num(a.lesson_number) - num(b.lesson_number) || a.week_number - b.week_number);
      g.lessons.forEach((l, i) => { l.displayNumber = l.lesson_number || i + 1; });
      return g;
    });
  }

  // The first lesson, in course order, the student still has to do, with
  // the group it sits in. null when everything is done.
  function nextLesson(groups, statusByLesson) {
    for (const g of groups) {
      const l = g.lessons.find(x => !DONE_STATUSES.includes(statusByLesson[x.id]));
      if (l) return { lesson: l, group: g };
    }
    return null;
  }

  window.ISMUnits = { DONE_STATUSES, STATUS_LABEL, groupIntoUnits, nextLesson };
})();
