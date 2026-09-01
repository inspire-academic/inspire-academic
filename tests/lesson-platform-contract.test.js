const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');
const platform = require('../assets/js/lesson-platform-contract-v1.js');

const schema = JSON.parse(fs.readFileSync(path.join(
  REPO_ROOT,
  'assets',
  'schemas',
  'lesson-content.v1.schema.json'
), 'utf8'));

const base = {
  schemaVersion: 1,
  lessonId: 'chemistry-example',
  subject: 'Chemistry',
  title: 'Example',
  blocks: [{
    id: 'explain-one',
    type: 'explanation',
    order: 1,
    learningGoal: 'Explain one idea.',
    tier: 'Both'
  }]
};

test('lesson content schema and runtime expose the same immutable v1 block vocabulary', () => {
  assert.equal(schema.properties.schemaVersion.const, platform.VERSION);
  assert.deepEqual(schema.$defs.baseBlock.properties.type.enum, [...platform.BLOCK_TYPES]);
  assert.equal(platform.validate(base).valid, true);
});

test('simulation extension requires a goal, inputs, fallback and accessibility metadata', () => {
  const simulation = {
    ...base,
    blocks: [{
      id: 'sim-one',
      type: 'simulation',
      order: 1,
      learningGoal: 'Explore how an input changes the outcome.',
      componentId: 'ratio-explorer',
      provider: 'replaceable-provider-name',
      inputs: { numerator: 4, denominator: 10 },
      fallback: { kind: 'diagram', content: '#ratio-diagram' },
      accessibility: {
        label: 'Ratio explorer',
        description: 'Adjust the numerator and compare the represented fraction.'
      }
    }]
  };
  assert.deepEqual(platform.validate(simulation), { valid: true, errors: [] });

  const invalid = structuredClone(simulation);
  delete invalid.blocks[0].fallback;
  assert.equal(platform.validate(invalid).valid, false);
  assert.match(platform.validate(invalid).errors.join(' '), /fallback/);
});

test('simulation resolution is provider-neutral and falls back without an adapter', () => {
  const block = {
    id: 'sim-one',
    type: 'simulation',
    order: 1,
    learningGoal: 'Explore a relationship.',
    componentId: 'relationship-explorer',
    provider: 'not-a-runtime-key',
    inputs: { start: 1 },
    fallback: { kind: 'text', content: 'Use the worked example.' },
    accessibility: { label: 'Explorer', description: 'An optional relationship explorer.' }
  };

  assert.deepEqual(platform.resolveSimulation(block), {
    mode: 'fallback',
    fallback: block.fallback,
    errors: []
  });

  const adapter = { mount() {} };
  const unregister = platform.registerAdapter('relationship-explorer', adapter);
  const resolved = platform.resolveSimulation(block);
  assert.equal(resolved.mode, 'interactive');
  assert.equal(resolved.adapter, adapter);
  unregister();
});

test('legacy lessons remain playable because the contract is never a rendering gate', () => {
  const contractDoc = fs.readFileSync(path.join(
    REPO_ROOT,
    'docs',
    'production',
    'LESSON-PLATFORM-CONTRACT-V1.md'
  ), 'utf8');
  assert.match(contractDoc, /legacy v0[\s\S]*continues? to render unchanged/i);
  assert.match(contractDoc, /progressive\s+enhancement, never a playback gate/i);
});

test('every committed v1 lesson content contract validates', () => {
  const dataDir = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'data');
  const files = fs.readdirSync(dataDir).filter(name => name.endsWith('.v1.json'));
  assert.ok(files.length > 0, 'expected at least one v1 lesson content contract');
  for (const name of files) {
    const contract = JSON.parse(fs.readFileSync(path.join(dataDir, name), 'utf8'));
    assert.deepEqual(platform.validate(contract), { valid: true, errors: [] }, name);
  }
});
