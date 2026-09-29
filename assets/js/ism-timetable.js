// ISM class timetable cards, shared by Personalised Learning
// (student/revision.html) and the Teacher Dashboard (teacher/teacher.html).
//
//   IATimetable.render(supabaseClient, userId, containerElement)
//
// Who sees what:
//   - staff (teacher, teacher_manager, admin, super_admin): every class
//     group's current timetable (or the next one once a term has ended),
//     one card per class group;
//   - pupils: only their own class group's, and only with an active row in
//     ism_enrolments.
// Row-level security enforces the same rules (supabase/ism_enrolments.sql),
// so this only decides what to draw. Cards are collapsed, and the image is
// only fetched once a card is opened. Any failure leaves the container empty.
(function () {
  const STAFF = ['teacher', 'teacher_manager', 'admin', 'super_admin'];
  const IMAGE_PATH = /^\/assets\/images\/ism\/[a-z0-9-]+\.webp$/;

  function card(classGroup, tt) {
    const label = `${classGroup} · ${tt.title}`;
    const d = document.createElement('details');
    d.className = 'timetable-card';
    d.innerHTML = `
      <summary class="timetable-summary">
        <span class="timetable-icon" aria-hidden="true">📅</span>
        <span class="timetable-text">
          <span class="timetable-label">ISM Class Timetable</span>
          <span class="timetable-title"></span>
          <span class="timetable-desc"></span>
        </span>
        <span class="timetable-toggle" aria-hidden="true">View</span>
      </summary>
      <div class="timetable-body">
        <a class="timetable-open" target="_blank" rel="noopener"><img alt="" width="1024" height="1536" decoding="async"></a>
        <div class="timetable-actions"><a class="btn btn-gold timetable-download" download>Download</a></div>
      </div>`;
    d.querySelector('.timetable-title').textContent = label;
    d.querySelector('.timetable-desc').textContent = tt.summary || '';
    d.querySelector('.timetable-open').href = tt.image_path;
    const dl = d.querySelector('.timetable-download');
    dl.href = tt.image_path;
    dl.download = `ISM-Timetable-${label}.webp`.replace(/[^A-Za-z0-9.-]+/g, '-');
    const img = d.querySelector('img');
    img.alt = `ISM ${label} timetable`;
    d.addEventListener('toggle', () => { if (d.open && !img.src) img.src = tt.image_path; });
    return d;
  }

  async function render(sb, userId, container) {
    if (!container) return;
    try {
      const today = new Date().toISOString().slice(0, 10);
      const { data: profile } = await sb.from('profiles').select('role').eq('id', userId).maybeSingle();
      let q = sb.from('ism_timetables').select('class_group, title, summary, image_path, valid_from')
        .gte('valid_to', today).order('class_group', { ascending: true }).order('valid_from', { ascending: true });
      if (!(profile && STAFF.includes(profile.role))) {
        const { data: enrolment } = await sb.from('ism_enrolments')
          .select('class_group').eq('student_id', userId).eq('status', 'active').maybeSingle();
        if (!enrolment) return;
        q = q.eq('class_group', enrolment.class_group);
      }
      const { data: rows } = await q;
      const seen = new Set();
      for (const tt of rows || []) {
        if (seen.has(tt.class_group) || !IMAGE_PATH.test(tt.image_path)) continue;   // current (or next) term only
        seen.add(tt.class_group);
        container.appendChild(card(tt.class_group, tt));
      }
    } catch (e) { /* leave it empty */ }
  }

  window.IATimetable = { render };
})();
