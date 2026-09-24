// PASCO Library catalogue — the pure, DOM-free half of
// teacher/pasco-library.html (the UI lives in pasco-library.js).
//
// Knows which Higher-tier GCSE papers *should* exist for every board,
// subject, year and series since the 9–1 specs were first examined, so
// the library can show an empty slot for each one until a file is
// uploaded. Also parses exam-board and Inspire filenames so a batch of
// downloaded files can be filed into the right slots automatically.
//
// Loaded as a plain <script> (sets window.PASCO_LIBRARY) and required
// by tests/pasco-library-catalogue.test.js (module.exports).
(function (root) {
  'use strict';

  var FIRST_YEAR = 2018;

  var BOARDS = ['AQA', 'Edexcel'];
  var SUBJECTS = ['Physics', 'Chemistry', 'Biology', 'Mathematics'];
  var TIERS = ['Higher']; // Foundation is a later project — add 'Foundation' here and to the SQL CHECK

  // Specification codes, per board. Paper counts: sciences 2, Maths 3.
  var SPEC_CODES = {
    AQA:     { Physics: '8463', Chemistry: '8462', Biology: '8461', Mathematics: '8300' },
    Edexcel: { Physics: '1PH0', Chemistry: '1CH0', Biology: '1BI0', Mathematics: '1MA1' }
  };

  var DOC_TYPES = [
    { id: 'paper',       label: 'Question paper' },
    { id: 'mark_scheme', label: 'Mark scheme' },
    { id: 'solution',    label: 'Inspire solution' }
  ];

  var SERIES = ['June', 'November'];

  function paperCount(subject) {
    return subject === 'Mathematics' ? 3 : 2;
  }

  function years(now) {
    var current = (now || new Date()).getFullYear();
    var out = [];
    for (var y = current; y >= FIRST_YEAR; y--) out.push(y);
    return out;
  }

  // Which sittings happened (or are scheduled) for a subject in a year.
  //  - Summer 2020 and 2021 were cancelled (COVID-19 — grades were
  //    centre/teacher assessed, no papers sat).
  //  - Maths has a November resit series every year.
  //  - Sciences only had November series in 2020 and 2021 (the
  //    autumn series offered in place of the cancelled summers).
  function seriesFor(subject, year) {
    var out = [];
    if (year === 2020 || year === 2021) {
      out.push({ series: 'June', cancelled: true, note: 'Summer exams cancelled (COVID-19) — no papers sat.' });
    } else {
      out.push({ series: 'June', cancelled: false });
    }
    if (subject === 'Mathematics' || year === 2020 || year === 2021) {
      out.push({ series: 'November', cancelled: false });
    }
    return out;
  }

  function paperLabel(board, subject, paperNumber) {
    return SPEC_CODES[board][subject] + '/' + paperNumber + 'H';
  }

  // Every slot expected for one board/subject/year, excluding cancelled series.
  function expectedSlots(board, subject, year) {
    var slots = [];
    seriesFor(subject, year).forEach(function (s) {
      if (s.cancelled) return;
      for (var p = 1; p <= paperCount(subject); p++) {
        DOC_TYPES.forEach(function (d) {
          slots.push(slotKey({ board: board, subject: subject, year: year, series: s.series, tier: 'Higher', paper: p, docType: d.id }));
        });
      }
    });
    return slots;
  }

  function slotKey(s) {
    return [s.board, s.subject, s.year, s.series, s.tier || 'Higher', s.paper, s.docType].join('|');
  }

  function rowToSlotKey(row) {
    return slotKey({
      board: row.board, subject: row.subject, year: row.exam_year, series: row.series,
      tier: row.tier, paper: row.paper_number, docType: row.doc_type
    });
  }

  function slugify(s) {
    return String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
  }

  // Deterministic, one object per slot — replacing a file overwrites it.
  function storagePath(s, ext) {
    return [
      slugify(s.board), slugify(s.subject), s.year + '-' + slugify(s.series),
      slugify(s.tier || 'Higher') + '-p' + s.paper + '-' + s.docType.replace('_', '-') + '.' + ext
    ].join('/');
  }

  function extOf(fileName) {
    var m = /\.([a-z0-9]+)$/i.exec(fileName || '');
    return m ? m[1].toLowerCase() : '';
  }

  var ALLOWED_EXTS = { pdf: 'application/pdf', html: 'text/html', htm: 'text/html' };

  function mimeFor(fileName) {
    return ALLOWED_EXTS[extOf(fileName)] || null;
  }

  function fullYear(yy) {
    var n = parseInt(yy, 10);
    return n < 100 ? 2000 + n : n;
  }

  function subjectFromCode(board, code) {
    var codes = SPEC_CODES[board];
    for (var subj in codes) {
      if (codes[subj].toLowerCase() === String(code).toLowerCase()) return subj;
    }
    return null;
  }

  function seriesFromMonth(mon) {
    var m = String(mon).toLowerCase().slice(0, 3);
    if (m === 'jun' || m === 'may') return 'June';
    if (m === 'nov' || m === 'oct') return 'November';
    return null;
  }

  // Recognises:
  //   AQA board downloads    AQA-84631H-QP-JUN22.PDF, AQA-83002H-W-MS-NOV21.PDF
  //   Edexcel downloads      1ph0-1h-que-20220520.pdf, 1ma1_2h_msc_20230111.pdf
  //   Inspire solutions      PASCO-AQA-Physics-1H-Jun2022-Review.html
  // Returns a slot descriptor or null. The caller always shows the
  // result for confirmation before anything is uploaded.
  function parseFileName(fileName) {
    var name = String(fileName || '');
    var m;

    m = /PASCO[-_ ](AQA|Edexcel)[-_ ](Physics|Chemistry|Biology|Maths|Mathematics)[-_ ]([123])H[-_ ](Jun|June|Nov|November)[-_ ]?(\d{4})/i.exec(name);
    if (m) {
      var subj = /^math/i.test(m[2]) ? 'Mathematics' : m[2].charAt(0).toUpperCase() + m[2].slice(1).toLowerCase();
      return finish({
        board: /^aqa$/i.test(m[1]) ? 'AQA' : 'Edexcel', subject: subj,
        year: fullYear(m[5]), series: seriesFromMonth(m[4]), paper: +m[3], docType: 'solution'
      });
    }

    // AQA appends a version digit to the series: JUN241 = June 2024, version 1.
    m = /(8461|8462|8463|8300)[-_ ]?([123])H\b.*?\b(QP|MS|INS)\b.*?\b(JUN|NOV)[-_ ]?((?:20)?\d{2})\d?\b/i.exec(name);
    if (m && m[3].toUpperCase() !== 'INS') {
      return finish({
        board: 'AQA', subject: subjectFromCode('AQA', m[1]),
        year: fullYear(m[5]), series: seriesFromMonth(m[4]), paper: +m[2],
        docType: m[3].toUpperCase() === 'QP' ? 'paper' : 'mark_scheme'
      });
    }

    m = /(1ph0|1ch0|1bi0|1ma1)[-_ ]?([123])h[-_ ](que|msc|rms)[-_ ](\d{4})(\d{2})\d{2}/i.exec(name);
    if (m) {
      var y = +m[4], mo = +m[5], docType = m[3].toLowerCase() === 'que' ? 'paper' : 'mark_scheme';
      var series;
      if (docType === 'paper') {
        series = mo >= 10 ? 'November' : (mo >= 5 && mo <= 6 ? 'June' : null);
      } else if (mo >= 7 && mo <= 9) {
        series = 'June';            // summer mark schemes publish Jul–Sep
      } else if (mo >= 10) {
        series = 'November';
      } else if (mo <= 3) {
        series = 'November'; y -= 1; // November mark schemes publish Jan–Mar of the following year
      } else {
        series = null;
      }
      return finish({
        board: 'Edexcel', subject: subjectFromCode('Edexcel', m[1]),
        year: y, series: series, paper: +m[2], docType: docType
      });
    }

    return null;
  }

  // Rejects parses that land outside the catalogue (e.g. a sciences
  // November outside 2020/21, or a year before 2018).
  function finish(s) {
    if (!s.subject || !s.series || !s.year) return null;
    s.tier = 'Higher';
    if (s.year < FIRST_YEAR || s.paper > paperCount(s.subject)) return null;
    var ok = seriesFor(s.subject, s.year).some(function (x) { return x.series === s.series && !x.cancelled; });
    return ok ? s : null;
  }

  var api = {
    FIRST_YEAR: FIRST_YEAR, BOARDS: BOARDS, SUBJECTS: SUBJECTS, TIERS: TIERS,
    SPEC_CODES: SPEC_CODES, DOC_TYPES: DOC_TYPES, SERIES: SERIES,
    paperCount: paperCount, years: years, seriesFor: seriesFor, paperLabel: paperLabel,
    expectedSlots: expectedSlots, slotKey: slotKey, rowToSlotKey: rowToSlotKey,
    storagePath: storagePath, extOf: extOf, mimeFor: mimeFor, parseFileName: parseFileName
  };

  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.PASCO_LIBRARY = api;
})(typeof window !== 'undefined' ? window : this);
