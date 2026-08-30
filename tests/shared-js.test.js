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

const CURRICULUM_SYSTEM = 'gcse-uk';

test('spec-map.js defines window.SPEC_MAP with all curriculum-systems/subjects/boards', () => {
  const code = fs.readFileSync(path.join(__dirname, '..', 'assets/js/spec-map.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);

  assert.ok(sandbox.window.SPEC_MAP, 'window.SPEC_MAP was not defined');
  const system = sandbox.window.SPEC_MAP[CURRICULUM_SYSTEM];
  assert.ok(system, `SPEC_MAP missing curriculum system: ${CURRICULUM_SYSTEM}`);
  for (const subject of SUBJECTS) {
    assert.ok(system[subject], `SPEC_MAP.${CURRICULUM_SYSTEM} missing subject: ${subject}`);
    for (const board of BOARDS) {
      const topics = system[subject][board];
      assert.ok(Array.isArray(topics) && topics.length > 0, `SPEC_MAP.${CURRICULUM_SYSTEM}.${subject}.${board} is empty or missing`);
      for (const t of topics) {
        assert.ok(t.slug && t.name, `SPEC_MAP.${CURRICULUM_SYSTEM}.${subject}.${board} has a topic missing slug/name`);
        assert.ok(Array.isArray(t.subtopics), `SPEC_MAP.${CURRICULUM_SYSTEM}.${subject}.${board}.${t.slug} missing subtopics array`);
      }
    }
  }
});

test('grade-scales.js defines window.GRADE_SCALES with a valid gcse-uk scale', () => {
  const code = fs.readFileSync(path.join(__dirname, '..', 'assets/js/grade-scales.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);

  assert.ok(sandbox.window.GRADE_SCALES, 'window.GRADE_SCALES was not defined');
  const scale = sandbox.window.GRADE_SCALES[CURRICULUM_SYSTEM];
  assert.ok(scale, `GRADE_SCALES missing curriculum system: ${CURRICULUM_SYSTEM}`);
  assert.deepEqual(scale.values, ['9','8','7','6','5','4','3','2','1','U']);
  assert.equal(scale.direction, 'higher-better');
  assert.equal(typeof scale.normReferenced, 'boolean');
  assert.ok(scale.passGrade, 'scale missing passGrade');
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
