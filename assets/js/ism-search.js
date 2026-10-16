// ISM Class lesson search, shared by ism-class/subject.html (one subject,
// filters the unit list) and ism-class/index.html (every subject, shows a
// results list). One set of rules so both searches behave the same.
(function () {
  // Lowercase, accents and punctuation stripped, so "Factorising",
  // "factorising," and "factorísing" all match.
  function normalise(text) {
    return String(text || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '')
      .replace(/[^a-z0-9]+/g, ' ').trim();
  }

  // The words typed, normalised. Empty array = not searching. "unit 2" and
  // "lesson 3" stay together as one term, so the number belongs to them.
  function words(query) {
    const parts = normalise(query).split(' ').filter(Boolean);
    const out = [];
    for (let i = 0; i < parts.length; i++) {
      if ((parts[i] === 'unit' || parts[i] === 'lesson') && /^\d+$/.test(parts[i + 1] || '')) {
        out.push(parts[i] + ' ' + parts[i + 1]); i++;
      } else out.push(parts[i]);
    }
    return out;
  }

  // Every term must appear, from the start of a word: "fact" finds
  // "factorising", but "in" doesn't find "Completing". A term ending in a
  // number must match it exactly, so "unit 2" isn't "unit 21". searchText
  // is already normalised (see haystack).
  function matches(searchText, ws) {
    const padded = ' ' + searchText + ' ';
    return ws.every(w => padded.includes(' ' + w + (/\d$/.test(w) ? ' ' : '')));
  }

  // Everything a student might type to find a lesson.
  function haystack(lesson, unit, statusLabel) {
    return normalise([
      lesson.title, lesson.description, `lesson ${lesson.displayNumber}`,
      unit ? `unit ${unit.unit_number} ${unit.title}` : '', statusLabel
    ].join(' '));
  }

  function esc(v) {
    return String(v == null ? '' : v).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  }

  // Escaped HTML of `plain` with the typed words (at word starts, as
  // matches() does) wrapped in <mark>. Works on plain text, so nothing a
  // teacher typed is ever parsed as HTML.
  function highlight(plain, ws) {
    plain = String(plain || '');
    const lower = plain.toLowerCase();
    const marks = new Array(plain.length).fill(false);
    ws.forEach(w => {
      for (let i = lower.indexOf(w); i !== -1; i = lower.indexOf(w, i + 1)) {
        if (i > 0 && /[a-z0-9]/.test(lower[i - 1])) continue;
        for (let k = i; k < i + w.length; k++) marks[k] = true;
      }
    });
    let html = '', open = false;
    for (let i = 0; i < plain.length; i++) {
      if (marks[i] && !open) { html += '<mark class="search-hit">'; open = true; }
      if (!marks[i] && open) { html += '</mark>'; open = false; }
      html += esc(plain[i]);
    }
    return html + (open ? '</mark>' : '');
  }

  // "2 lessons match" / "1 lesson matches" / '' for none.
  function countText(n) {
    return !n ? '' : n === 1 ? '1 lesson matches' : `${n} lessons match`;
  }

  window.ISMSearch = { normalise, words, matches, haystack, highlight, countText, esc };
})();
