'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const sharp = require('sharp');

const {
  BridgeError,
  parseRequest,
  buildPrompt,
  validateTargetAsset,
  validateRequestFile,
  generateWithRetries,
  runBridge,
} = require('../scripts/generate-premium-figure');

const REPO_ROOT = path.resolve(__dirname, '..');

function validRequest(overrides = {}) {
  const values = {
    id: 'CHEM-TEST-PFF-001',
    targetAsset: 'assets/images/chemistry/diagrams/test/CHEM-TEST-PFF-001.webp',
    targetDimensions: '96 × 64 px',
    performanceBudget: '20 KB maximum',
    ...overrides,
  };
  return `# Test premium figure request

\`\`\`yaml
id: ${values.id}
status: ready
authoringMode: premium-final-figure
subject: GCSE Chemistry
topic: Test chemistry
lessonFile: teaching-lessons/chemistry/test.html
placement: Representations
tier: both
aspectRatio: 3:2 landscape
targetAsset: ${values.targetAsset}
targetDimensions: "${values.targetDimensions}"
performanceBudget: "${values.performanceBudget}"
humanApproval: pending
\`\`\`

## Pedagogical purpose
Teach the exact particle relationship.

## Three-second learner takeaway
Positive ions move to the cathode.

## Exact scientific scenario
A single labelled electrolytic cell.

## Exact labels and notation
Render \`Na⁺\` and \`Cl⁻\` exactly.

## Required relationships
The Na⁺ arrow points to the cathode.

## Misconceptions to prevent
Electrons do not cross the electrolyte.

## Forbidden or misleading content
No reversed arrows and no invented products.

## Visual hierarchy and direction
Calm premium GCSE textbook composition.

## Framing, accessibility and performance
Self-contained landscape figure with legible labels.

## Scientific verification checklist
- [ ] Charges and arrow directions are correct.

## Generation prompt
\`\`\`text
Create the complete final educational figure with exact notation.
\`\`\`

## Human approval state
Pending explicit human visual approval.
`;
}

function makeTempRepo(t) {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'visual-asset-bridge-'));
  fs.mkdirSync(path.join(root, 'docs', 'visual-requests'), { recursive: true });
  fs.mkdirSync(path.join(root, 'assets', 'images'), { recursive: true });
  fs.writeFileSync(path.join(root, 'docs', 'visual-requests', 'request.md'), validRequest());
  t.after(() => fs.rmSync(root, { recursive: true, force: true, maxRetries: 5, retryDelay: 50 }));
  return root;
}

async function mockPng() {
  return sharp({
    create: {
      width: 180,
      height: 120,
      channels: 4,
      background: { r: 28, g: 46, b: 65, alpha: 1 },
    },
  }).png().toBuffer();
}

test('canonical Electrolysis requests validate and preserve exact authored constraints in prompts', () => {
  const cases = [
    ['CHEM-ELEC-PFF-001.md', 'Pb²⁺ + 2e⁻ → Pb', 'Never draw an electron-flow arrow across the electrolyte.'],
    ['CHEM-ELEC-PFF-002.md', 'AQUEOUS NaCl(aq)', 'Do not state which products form from NaCl(aq)'],
  ];
  for (const [file, notation, constraint] of cases) {
    const absolute = path.join(REPO_ROOT, 'docs', 'visual-requests', file);
    const request = parseRequest(fs.readFileSync(absolute, 'utf8'), file);
    const prompt = buildPrompt(request);
    assert.equal(request.frontmatter.id, path.basename(file, '.md'));
    assert.match(prompt, new RegExp(notation.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
    assert.ok(prompt.includes(constraint));
    assert.ok(prompt.includes('COMPLETE FINAL EDUCATIONAL FIGURE'));
  }
});

test('request validation rejects a missing required contract field', () => {
  const markdown = validRequest().replace(/^tier:.*\r?\n/m, '');
  assert.throws(() => parseRequest(markdown), error => {
    assert.equal(error.code, 'INVALID_REQUEST');
    assert.match(error.message, /tier/);
    return true;
  });
});

test('request and target paths cannot escape their allowed repository directories', () => {
  assert.throws(() => validateRequestFile(REPO_ROOT, '../request.md'), { code: 'UNSAFE_PATH' });
  const request = parseRequest(validRequest({ targetAsset: '../CHEM-TEST-PFF-001.webp' }));
  assert.throws(() => validateTargetAsset(REPO_ROOT, request), { code: 'UNSAFE_PATH' });
  const wrongExtension = parseRequest(validRequest({ targetAsset: 'assets/images/CHEM-TEST-PFF-001.png' }));
  assert.throws(() => validateTargetAsset(REPO_ROOT, wrongExtension), { code: 'UNSAFE_PATH' });
  const wrongId = parseRequest(validRequest({ targetAsset: 'assets/images/OTHER.webp' }));
  assert.throws(() => validateTargetAsset(REPO_ROOT, wrongId), { code: 'UNSAFE_PATH' });
});

test('missing API key fails before request parsing or generation', async () => {
  await assert.rejects(
    runBridge({ repoRoot: REPO_ROOT, requestFile: 'not-a-request.md', env: {} }),
    error => error instanceof BridgeError && error.code === 'MISSING_API_KEY',
  );
});

test('mocked generation writes raw source, optimized WebP and a secret-free generation record', async t => {
  const root = makeTempRepo(t);
  const source = await mockPng();
  const calls = [];
  const secret = 'sk-test-secret-that-must-never-be-written';
  const result = await runBridge({
    repoRoot: root,
    requestFile: 'docs/visual-requests/request.md',
    env: {
      OPENAI_API_KEY: secret,
      OPENAI_IMAGE_MODEL: 'gpt-image-test',
      OPENAI_IMAGE_QUALITY: 'medium',
    },
    generateImage: async params => {
      calls.push(params);
      return { _request_id: 'req_mock_123', data: [{ b64_json: source.toString('base64') }] };
    },
    now: () => new Date('2026-08-25T10:20:30.000Z'),
  });

  assert.equal(calls.length, 1);
  assert.deepEqual(calls[0], {
    model: 'gpt-image-test',
    prompt: result.prompt,
    size: '1536x1024',
    quality: 'medium',
  });
  assert.ok(fs.existsSync(result.sourcePath));
  assert.ok(fs.existsSync(result.productionPath));
  assert.ok(fs.existsSync(result.recordPath));

  const metadata = await sharp(fs.readFileSync(result.productionPath)).metadata();
  assert.equal(metadata.format, 'webp');
  assert.ok(metadata.width <= 96);
  assert.ok(metadata.height <= 64);
  assert.ok(fs.statSync(result.productionPath).size <= 20 * 1024);

  const recordText = fs.readFileSync(result.recordPath, 'utf8');
  const record = JSON.parse(recordText);
  assert.equal(record.model, 'gpt-image-test');
  assert.equal(record.apiRequestId, 'req_mock_123');
  assert.equal(record.humanApprovalStatus, 'pending');
  assert.equal(record.generationResult, 'success');
  assert.ok(record.generatedPrompt.includes('Na⁺'));
  assert.ok(!recordText.includes(secret));
});

test('malformed API output creates no production asset or fallback SVG', async t => {
  const root = makeTempRepo(t);
  await assert.rejects(
    runBridge({
      repoRoot: root,
      requestFile: 'docs/visual-requests/request.md',
      env: { OPENAI_API_KEY: 'sk-test' },
      generateImage: async () => ({ data: [{}] }),
    }),
    { code: 'MALFORMED_RESPONSE' },
  );
  assert.equal(fs.existsSync(path.join(root, 'assets', 'images', 'chemistry')), false);
  assert.equal(fs.readdirSync(root, { recursive: true }).some(name => String(name).endsWith('.svg')), false);
});

test('API failure is classified, redacted and creates no output files', async t => {
  const root = makeTempRepo(t);
  const secret = 'sk-private-test';
  const error = new Error(`authentication rejected for ${secret}`);
  error.status = 401;
  await assert.rejects(
    runBridge({
      repoRoot: root,
      requestFile: 'docs/visual-requests/request.md',
      env: { OPENAI_API_KEY: secret },
      generateImage: async () => { throw error; },
    }),
    caught => {
      assert.equal(caught.code, 'AUTHENTICATION_FAILED');
      assert.ok(!caught.message.includes(secret));
      return true;
    },
  );
  assert.equal(fs.existsSync(path.join(root, '.generated')), false);
  assert.equal(fs.existsSync(path.join(root, 'docs', 'visual-generation-records')), false);
});

test('transient API errors retry only to the configured bound', async () => {
  let calls = 0;
  const error = Object.assign(new Error('busy'), { status: 429 });
  await assert.rejects(
    generateWithRetries(async () => {
      calls += 1;
      throw error;
    }, { attempts: 3, sleep: async () => {} }),
    error,
  );
  assert.equal(calls, 3);
});

test('non-transient API errors are not retried', async () => {
  let calls = 0;
  const error = Object.assign(new Error('bad request'), { status: 400 });
  await assert.rejects(
    generateWithRetries(async () => {
      calls += 1;
      throw error;
    }, { attempts: 3, sleep: async () => {} }),
    error,
  );
  assert.equal(calls, 1);
});

test('an existing production asset is never overwritten', async t => {
  const root = makeTempRepo(t);
  const target = path.join(root, 'assets', 'images', 'chemistry', 'diagrams', 'test', 'CHEM-TEST-PFF-001.webp');
  fs.mkdirSync(path.dirname(target), { recursive: true });
  fs.writeFileSync(target, 'existing asset');
  await assert.rejects(
    runBridge({
      repoRoot: root,
      requestFile: 'docs/visual-requests/request.md',
      env: { OPENAI_API_KEY: 'sk-test' },
      generateImage: async () => { throw new Error('must not be called'); },
    }),
    { code: 'OUTPUT_EXISTS' },
  );
  assert.equal(fs.readFileSync(target, 'utf8'), 'existing asset');
});
