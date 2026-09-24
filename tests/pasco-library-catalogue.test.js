// assets/js/pasco-library-catalogue.js — the slot catalogue and filename
// parser behind teacher/pasco-library.html. A wrong series rule shows
// empty slots for sittings that never happened; a wrong parse files a
// paper into the wrong slot during bulk upload.
const test = require('node:test');
const assert = require('node:assert/strict');
const CAT = require('../assets/js/pasco-library-catalogue.js');

test('years run from the current year back to 2018, newest first', () => {
  const ys = CAT.years(new Date('2026-09-24'));
  assert.equal(ys[0], 2026);
  assert.equal(ys[ys.length - 1], 2018);
  assert.equal(ys.length, 9);
});

test('summer 2020 and 2021 are cancelled; sciences only have November in 2020/21', () => {
  for (const y of [2020, 2021]) {
    const s = CAT.seriesFor('Physics', y);
    assert.deepEqual(s.map(x => [x.series, x.cancelled]), [['June', true], ['November', false]]);
  }
  assert.deepEqual(CAT.seriesFor('Chemistry', 2022).map(x => x.series), ['June']);
  assert.deepEqual(CAT.seriesFor('Mathematics', 2022).map(x => x.series), ['June', 'November']);
});

test('expected slots: sciences 2 papers x 3 docs, maths 3 papers x 3 docs per series', () => {
  assert.equal(CAT.expectedSlots('AQA', 'Physics', 2023).length, 6);
  assert.equal(CAT.expectedSlots('AQA', 'Physics', 2020).length, 6);  // November only
  assert.equal(CAT.expectedSlots('Edexcel', 'Mathematics', 2019).length, 18);
});

test('storage paths are deterministic per slot', () => {
  const slot = { board: 'AQA', subject: 'Physics', year: 2022, series: 'June', tier: 'Higher', paper: 1, docType: 'mark_scheme' };
  assert.equal(CAT.storagePath(slot, 'pdf'), 'aqa/physics/2022-june/higher-p1-mark-scheme.pdf');
});

test('parses AQA board filenames', () => {
  assert.deepEqual(pick(CAT.parseFileName('AQA-84631H-QP-JUN22.PDF')),
    ['AQA', 'Physics', 2022, 'June', 1, 'paper']);
  assert.deepEqual(pick(CAT.parseFileName('AQA-83002H-W-MS-NOV21.PDF')),
    ['AQA', 'Mathematics', 2021, 'November', 2, 'mark_scheme']);
  assert.deepEqual(pick(CAT.parseFileName('AQA-84612H-QP-JUN19.pdf')),
    ['AQA', 'Biology', 2019, 'June', 2, 'paper']);
});

test('parses Edexcel filenames, including November mark schemes published in January', () => {
  assert.deepEqual(pick(CAT.parseFileName('1ph0-1h-que-20220520.pdf')),
    ['Edexcel', 'Physics', 2022, 'June', 1, 'paper']);
  assert.deepEqual(pick(CAT.parseFileName('1ph0_1h_msc_20220825.pdf')),
    ['Edexcel', 'Physics', 2022, 'June', 1, 'mark_scheme']);
  assert.deepEqual(pick(CAT.parseFileName('1ma1-3h-que-20221110.pdf')),
    ['Edexcel', 'Mathematics', 2022, 'November', 3, 'paper']);
  assert.deepEqual(pick(CAT.parseFileName('1ma1_3h_msc_20230111.pdf')),
    ['Edexcel', 'Mathematics', 2022, 'November', 3, 'mark_scheme']);
});

test('parses Inspire solution filenames', () => {
  assert.deepEqual(pick(CAT.parseFileName('PASCO-AQA-Chemistry-2H-Nov2020-Review.html')),
    ['AQA', 'Chemistry', 2020, 'November', 2, 'solution']);
  assert.deepEqual(pick(CAT.parseFileName('PASCO-AQA-Maths-3H-Jun2024-Review.html')),
    ['AQA', 'Mathematics', 2024, 'June', 3, 'solution']);
});

test('rejects files outside the catalogue or unrecognised', () => {
  assert.equal(CAT.parseFileName('PASCO-Physics-Paper1-Review.html'), null);    // no board/series
  assert.equal(CAT.parseFileName('AQA-84631H-QP-NOV22.PDF'), null);             // no science Nov 2022
  assert.equal(CAT.parseFileName('AQA-84633H-QP-JUN22.PDF'), null);             // sciences have no paper 3
  assert.equal(CAT.parseFileName('AQA-84631H-QP-JUN17.PDF'), null);             // pre-2018
  assert.equal(CAT.parseFileName('AQA-84631H-INS-JUN22.PDF'), null);            // insert, not a paper
  assert.equal(CAT.parseFileName('holiday.pdf'), null);
});

test('only PDF and HTML are accepted', () => {
  assert.equal(CAT.mimeFor('a.PDF'), 'application/pdf');
  assert.equal(CAT.mimeFor('a.html'), 'text/html');
  assert.equal(CAT.mimeFor('a.docx'), null);
});

function pick(s) {
  assert.ok(s, 'expected a parse');
  return [s.board, s.subject, s.year, s.series, s.paper, s.docType];
}
