// Regression tests for the shared data files built this session
// (assets/js/spec-map.js, assets/js/core-topics.js). Both are consumed
// by multiple pages (teacher/quiz-generator.html,
// teacher/teacher-assessment-create.html, dashboard.html,
// subjects.html) — a shape change in either silently breaks every
// consumer at once, which is exactly the kind of shared-file risk
// CLAUDE.md's "one file at a time" rule is about.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const SUBJECTS = ['Physics', 'Chemistry', 'Biology', 'Maths'];
const BOARDS = ['AQA', 'Edexcel'];

test('spec-map.js defines window.SPEC_MAP with all subjects/boards', () => {
  const code = fs.readFileSync(path.join(__dirname, '..', 'assets/js/spec-map.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);

  assert.ok(sandbox.window.SPEC_MAP, 'window.SPEC_MAP was not defined');
  for (const subject of SUBJECTS) {
    assert.ok(sandbox.window.SPEC_MAP[subject], `SPEC_MAP missing subject: ${subject}`);
    for (const board of BOARDS) {
      const topics = sandbox.window.SPEC_MAP[subject][board];
      assert.ok(Array.isArray(topics) && topics.length > 0, `SPEC_MAP.${subject}.${board} is empty or missing`);
      for (const t of topics) {
        assert.ok(t.slug && t.name, `SPEC_MAP.${subject}.${board} has a topic missing slug/name`);
        assert.ok(Array.isArray(t.subtopics), `SPEC_MAP.${subject}.${board}.${t.slug} missing subtopics array`);
      }
    }
  }
});

test('core-topics.js defines window.CORE_TOPICS with 8 topics per subject', () => {
  const code = fs.readFileSync(path.join(__dirname, '..', 'assets/js/core-topics.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);

  assert.ok(sandbox.window.CORE_TOPICS, 'window.CORE_TOPICS was not defined');
  for (const subjectId of [1, 2, 3, 4]) {
    const topics = sandbox.window.CORE_TOPICS[subjectId];
    assert.ok(Array.isArray(topics), `CORE_TOPICS[${subjectId}] is not an array`);
    assert.equal(topics.length, 8, `CORE_TOPICS[${subjectId}] should have 8 topics, has ${topics.length}`);
  }
});
