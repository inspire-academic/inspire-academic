'use strict';

const fs = require('node:fs');
const path = require('node:path');
const sharp = require('sharp');

const DEFAULT_MODEL = 'gpt-image-2';
const DEFAULT_QUALITY = 'high';
const MAX_API_ATTEMPTS = 3;
const REQUIRED_FRONTMATTER = [
  'id', 'authoringMode', 'subject', 'topic', 'lessonFile', 'placement',
  'tier', 'aspectRatio', 'targetAsset', 'targetDimensions',
  'performanceBudget', 'humanApproval'
];
const REQUIRED_SECTIONS = [
  'pedagogical purpose',
  'three-second learner takeaway',
  'exact scientific scenario',
  'exact labels and notation',
  'misconceptions to prevent',
  'forbidden or misleading content',
  'visual hierarchy and direction',
  'framing, accessibility and performance',
  'scientific verification checklist',
  'generation prompt',
  'human approval state'
];

class BridgeError extends Error {
  constructor(code, message, cause) {
    super(message, { cause });
    this.name = 'BridgeError';
    this.code = code;
  }
}

function unquote(value) {
  const trimmed = String(value ?? '').trim();
  if (trimmed.length >= 2 && trimmed.startsWith('"') && trimmed.endsWith('"')) {
    try { return JSON.parse(trimmed); } catch { return trimmed.slice(1, -1); }
  }
  if (trimmed.length >= 2 && trimmed.startsWith("'") && trimmed.endsWith("'")) {
    return trimmed.slice(1, -1);
  }
  return trimmed;
}

function parseFrontmatter(markdown) {
  const match = markdown.match(/```yaml\r?\n([\s\S]*?)\r?\n```/i);
  if (!match) return null;
  const out = {};
  const lines = match[1].split(/\r?\n/);
  let currentKey = null;
  for (const line of lines) {
    const listItem = line.match(/^\s+-\s+(.*)$/);
    if (listItem && currentKey) {
      if (!Array.isArray(out[currentKey])) out[currentKey] = [];
      out[currentKey].push(unquote(listItem[1]));
      continue;
    }
    const kv = line.match(/^(\w+):\s*(.*)$/);
    if (kv) {
      currentKey = kv[1];
      out[currentKey] = kv[2].trim() === '' ? null : unquote(kv[2]);
    }
  }
  return out;
}

function normalizeHeading(heading) {
  return heading
    .toLowerCase()
    .replace(/[`*_]/g, '')
    .replace(/[^a-z0-9]+/g, ' ')
    .trim();
}

function extractSections(markdown) {
  const headings = [];
  const re = /^##\s+(.+?)\s*$/gm;
  let match;
  while ((match = re.exec(markdown))) {
    headings.push({
      name: normalizeHeading(match[1]),
      headingStart: match.index,
      contentStart: re.lastIndex,
    });
  }
  const sections = {};
  for (let i = 0; i < headings.length; i += 1) {
    const current = headings[i];
    const end = i + 1 < headings.length ? headings[i + 1].headingStart : markdown.length;
    sections[current.name] = markdown.slice(current.contentStart, end).trim();
  }
  return sections;
}

function findSection(sections, exactName, includesName) {
  const exact = normalizeHeading(exactName);
  const includes = normalizeHeading(includesName || exactName);
  if (sections[exact]) return sections[exact];
  const key = Object.keys(sections).find(name => name.includes(includes));
  return key ? sections[key] : '';
}

function stripOuterFence(value) {
  const trimmed = value.trim();
  const match = trimmed.match(/^```(?:text)?\r?\n([\s\S]*?)\r?\n```$/i);
  return match ? match[1].trim() : trimmed;
}

function parseDimensions(value) {
  const match = String(value).match(/(\d{2,5})\s*(?:×|x)\s*(\d{2,5})/i);
  if (!match) throw new BridgeError('INVALID_REQUEST', `Invalid targetDimensions: "${value}"`);
  const width = Number(match[1]);
  const height = Number(match[2]);
  if (width < 64 || height < 64 || width > 4096 || height > 4096) {
    throw new BridgeError('INVALID_REQUEST', 'targetDimensions must be between 64 and 4096 pixels per edge');
  }
  return { width, height };
}

function parseBudgetBytes(value) {
  const match = String(value).match(/(\d+(?:\.\d+)?)\s*(KB|MB)/i);
  if (!match) throw new BridgeError('INVALID_REQUEST', `Invalid performanceBudget: "${value}"`);
  const multiplier = match[2].toUpperCase() === 'MB' ? 1024 * 1024 : 1024;
  return Math.floor(Number(match[1]) * multiplier);
}

function resolveInside(repoRoot, relativePath, allowedDirectory, label) {
  const raw = String(relativePath || '').replace(/\\/g, '/');
  if (!raw || path.isAbsolute(raw) || raw.startsWith('/') || raw.split('/').includes('..')) {
    throw new BridgeError('UNSAFE_PATH', `${label} must be a repository-relative path without traversal`);
  }
  const resolved = path.resolve(repoRoot, raw);
  const allowed = path.resolve(repoRoot, allowedDirectory);
  if (resolved !== allowed && !resolved.startsWith(`${allowed}${path.sep}`)) {
    throw new BridgeError('UNSAFE_PATH', `${label} must stay inside ${allowedDirectory.replace(/\\/g, '/')}`);
  }
  return resolved;
}

function validateTargetAsset(repoRoot, request) {
  const target = resolveInside(repoRoot, request.frontmatter.targetAsset, 'assets/images', 'targetAsset');
  if (path.extname(target).toLowerCase() !== '.webp') {
    throw new BridgeError('UNSAFE_PATH', 'targetAsset must be a .webp file');
  }
  if (path.basename(target, '.webp') !== request.frontmatter.id) {
    throw new BridgeError('UNSAFE_PATH', 'targetAsset filename must match the request ID');
  }
  return target;
}

function validateRequestFile(repoRoot, requestFile) {
  const resolved = path.resolve(repoRoot, requestFile);
  const allowed = path.resolve(repoRoot, 'docs/visual-requests');
  if (!resolved.startsWith(`${allowed}${path.sep}`) || path.extname(resolved).toLowerCase() !== '.md') {
    throw new BridgeError('UNSAFE_PATH', 'Request file must be a Markdown file inside docs/visual-requests');
  }
  return resolved;
}

function parseRequest(markdown, sourcePath = '<memory>') {
  const frontmatter = parseFrontmatter(markdown);
  if (!frontmatter) throw new BridgeError('INVALID_REQUEST', `${sourcePath} has no fenced YAML request block`);

  const missingFields = REQUIRED_FRONTMATTER.filter(field => !frontmatter[field]);
  if (missingFields.length) {
    throw new BridgeError('INVALID_REQUEST', `${sourcePath} is missing required field(s): ${missingFields.join(', ')}`);
  }
  if (frontmatter.authoringMode !== 'premium-final-figure') {
    throw new BridgeError('INVALID_REQUEST', 'Visual Asset Bridge v1 accepts only premium-final-figure requests');
  }
  if (!/^[A-Z0-9][A-Z0-9-]{2,80}$/.test(frontmatter.id)) {
    throw new BridgeError('INVALID_REQUEST', `Invalid request ID: "${frontmatter.id}"`);
  }

  const sections = extractSections(markdown);
  const missingSections = REQUIRED_SECTIONS.filter(name => !findSection(sections, name));
  if (missingSections.length) {
    throw new BridgeError('INVALID_REQUEST', `${sourcePath} is missing required section(s): ${missingSections.join(', ')}`);
  }

  return {
    frontmatter,
    sections,
    dimensions: parseDimensions(frontmatter.targetDimensions),
    budgetBytes: parseBudgetBytes(frontmatter.performanceBudget)
  };
}

function buildPrompt(request) {
  const fm = request.frontmatter;
  const sections = request.sections;
  const relationships = findSection(sections, 'required relationships', 'relationships');
  const authoredPrompt = stripOuterFence(findSection(sections, 'generation prompt'));
  const blocks = [
    'Generate the COMPLETE FINAL EDUCATIONAL FIGURE. All scientific labels, notation, arrows and annotations must be complete in the returned image; do not leave content for HTML, SVG or another overlay to repair.',
    'Do not invent additional scientific content. Reproduce supplied notation and labels exactly, obey every arrow direction and apparatus relationship, and exclude every forbidden or misleading element.',
    `Request ID: ${fm.id}`,
    `Subject and topic: ${fm.subject} — ${fm.topic}`,
    `Learner level/tier: ${fm.tier}`,
    `Lesson placement: ${fm.lessonFile} — ${fm.placement}`,
    `Aspect ratio: ${fm.aspectRatio}`,
    `Pedagogical purpose:\n${findSection(sections, 'pedagogical purpose')}`,
    `Three-second learner takeaway:\n${findSection(sections, 'three-second learner takeaway')}`,
    `Exact scientific scenario:\n${findSection(sections, 'exact scientific scenario')}`,
    `Exact required labels and notation:\n${findSection(sections, 'exact labels and notation')}`,
    relationships ? `Required arrows, directions and relationships:\n${relationships}` : '',
    `Misconceptions to prevent:\n${findSection(sections, 'misconceptions to prevent')}`,
    `Forbidden or misleading content:\n${findSection(sections, 'forbidden or misleading content')}`,
    `Visual hierarchy and Inspire direction:\n${findSection(sections, 'visual hierarchy and direction')}`,
    `Framing, accessibility and performance context:\n${findSection(sections, 'framing accessibility and performance', 'framing accessibility')}`,
    `Scientific verification criteria:\n${findSection(sections, 'scientific verification checklist')}`,
    `Author-supplied generation direction:\n${authoredPrompt}`
  ];
  return blocks.filter(Boolean).join('\n\n');
}

function chooseApiSize({ width, height }) {
  const ratio = width / height;
  if (ratio > 1.15) return '1536x1024';
  if (ratio < 0.87) return '1024x1536';
  return '1024x1024';
}

function isTransient(error) {
  const status = Number(error?.status || error?.statusCode || 0);
  if ([408, 409, 429].includes(status) || status >= 500) return true;
  return ['ECONNRESET', 'ETIMEDOUT', 'EAI_AGAIN', 'ENETUNREACH'].includes(error?.code);
}

async function generateWithRetries(call, options = {}) {
  const attempts = options.attempts || MAX_API_ATTEMPTS;
  const sleep = options.sleep || (ms => new Promise(resolve => setTimeout(resolve, ms)));
  let lastError;
  for (let attempt = 1; attempt <= attempts; attempt += 1) {
    try {
      return await call(attempt);
    } catch (error) {
      lastError = error;
      if (!isTransient(error) || attempt === attempts) throw error;
      await sleep(500 * (2 ** (attempt - 1)));
    }
  }
  throw lastError;
}

function createOpenAIImageCall(apiKey) {
  const OpenAIModule = require('openai');
  const OpenAI = OpenAIModule.default || OpenAIModule;
  const client = new OpenAI({ apiKey });
  return params => client.images.generate(params);
}

function decodeImageResponse(response) {
  const encoded = response?.data?.[0]?.b64_json;
  if (typeof encoded !== 'string' || encoded.length < 16) {
    throw new BridgeError('MALFORMED_RESPONSE', 'OpenAI returned no base64 image');
  }
  const image = Buffer.from(encoded, 'base64');
  if (!image.length) throw new BridgeError('MALFORMED_RESPONSE', 'OpenAI returned an empty image');
  return image;
}

async function optimiseWebp(sourceBuffer, dimensions, budgetBytes) {
  let last;
  for (let quality = 86; quality >= 54; quality -= 4) {
    const buffer = await sharp(sourceBuffer)
      .rotate()
      .resize(dimensions.width, dimensions.height, { fit: 'inside', withoutEnlargement: true })
      .webp({ quality, effort: 6 })
      .toBuffer();
    last = { buffer, quality };
    if (buffer.length <= budgetBytes) return last;
  }
  throw new BridgeError(
    'CONVERSION_FAILED',
    `Unable to meet the ${budgetBytes}-byte performance budget without dropping below the minimum WebP quality`
  );
}

function fileStamp(date) {
  return date.toISOString().replace(/[-:.]/g, '').replace('Z', 'Z');
}

function relativeRepoPath(repoRoot, file) {
  return path.relative(repoRoot, file).replace(/\\/g, '/');
}

function assertAbsent(file, label) {
  if (fs.existsSync(file)) throw new BridgeError('OUTPUT_EXISTS', `${label} already exists: ${file}`);
}

function sanitiseError(error, secrets = []) {
  let message = error instanceof Error ? error.message : String(error);
  for (const secret of secrets.filter(Boolean)) message = message.split(secret).join('[REDACTED]');
  return message;
}

async function runBridge(options) {
  const repoRoot = path.resolve(options.repoRoot);
  const env = options.env || process.env;
  const apiKey = env.OPENAI_API_KEY;
  if (!apiKey) {
    throw new BridgeError('MISSING_API_KEY', 'OPENAI_API_KEY is not configured');
  }

  const requestPath = validateRequestFile(repoRoot, options.requestFile);
  let markdown;
  try {
    markdown = fs.readFileSync(requestPath, 'utf8');
  } catch (error) {
    throw new BridgeError('FILESYSTEM_FAILURE', `Unable to read request file: ${requestPath}`, error);
  }
  const request = parseRequest(markdown, relativeRepoPath(repoRoot, requestPath));
  const productionPath = validateTargetAsset(repoRoot, request);
  assertAbsent(productionPath, 'Production asset');

  const now = options.now ? options.now() : new Date();
  const stamp = fileStamp(now);
  const sourcePath = path.join(repoRoot, '.generated', 'visual-assets', request.frontmatter.id, `${stamp}-source.png`);
  const recordPath = path.join(repoRoot, 'docs', 'visual-generation-records', `${request.frontmatter.id}-${stamp}.json`);
  assertAbsent(sourcePath, 'Source asset');
  assertAbsent(recordPath, 'Generation record');

  const prompt = buildPrompt(request);
  const model = env.OPENAI_IMAGE_MODEL || DEFAULT_MODEL;
  const quality = env.OPENAI_IMAGE_QUALITY || DEFAULT_QUALITY;
  if (!['low', 'medium', 'high', 'auto'].includes(quality)) {
    throw new BridgeError('INVALID_CONFIGURATION', 'OPENAI_IMAGE_QUALITY must be low, medium, high or auto');
  }
  const apiParams = {
    model,
    prompt,
    size: chooseApiSize(request.dimensions),
    quality
  };
  const imageCall = options.generateImage || createOpenAIImageCall(apiKey);

  let response;
  try {
    response = await generateWithRetries(() => imageCall(apiParams), {
      attempts: MAX_API_ATTEMPTS,
      sleep: options.sleep
    });
  } catch (error) {
    const status = Number(error?.status || error?.statusCode || 0);
    const code = status === 401 ? 'AUTHENTICATION_FAILED'
      : status === 429 ? 'RATE_LIMITED'
        : isTransient(error) ? 'TRANSIENT_API_FAILURE' : 'GENERATION_FAILED';
    throw new BridgeError(code, sanitiseError(error, [apiKey]), error);
  }

  const sourceBuffer = decodeImageResponse(response);
  let sourceMetadata;
  let production;
  try {
    sourceMetadata = await sharp(sourceBuffer).metadata();
    if (!sourceMetadata.width || !sourceMetadata.height) {
      throw new Error('Generated image has no readable dimensions');
    }
    production = await optimiseWebp(sourceBuffer, request.dimensions, request.budgetBytes);
  } catch (error) {
    if (error instanceof BridgeError) throw error;
    throw new BridgeError('CONVERSION_FAILED', sanitiseError(error, [apiKey]), error);
  }

  try {
    fs.mkdirSync(path.dirname(sourcePath), { recursive: true });
    fs.mkdirSync(path.dirname(productionPath), { recursive: true });
    fs.mkdirSync(path.dirname(recordPath), { recursive: true });
    fs.writeFileSync(sourcePath, sourceBuffer, { flag: 'wx' });
    fs.writeFileSync(productionPath, production.buffer, { flag: 'wx' });
    const productionMetadata = await sharp(production.buffer).metadata();
    const record = {
      schemaVersion: 1,
      requestId: request.frontmatter.id,
      requestFile: relativeRepoPath(repoRoot, requestPath),
      timestamp: now.toISOString(),
      model,
      apiRequestId: response?._request_id || null,
      generatedPrompt: prompt,
      generationResult: 'success',
      technicalValidationStatus: 'generated-and-optimised; scientific-and-visual-review-required',
      humanApprovalStatus: request.frontmatter.humanApproval,
      source: {
        path: relativeRepoPath(repoRoot, sourcePath),
        format: sourceMetadata.format || 'png',
        width: sourceMetadata.width,
        height: sourceMetadata.height,
        bytes: sourceBuffer.length
      },
      production: {
        path: relativeRepoPath(repoRoot, productionPath),
        format: 'webp',
        width: productionMetadata.width,
        height: productionMetadata.height,
        bytes: production.buffer.length,
        quality: production.quality,
        performanceBudgetBytes: request.budgetBytes
      }
    };
    fs.writeFileSync(recordPath, `${JSON.stringify(record, null, 2)}\n`, { flag: 'wx' });
    return { request, prompt, record, recordPath, sourcePath, productionPath, apiParams };
  } catch (error) {
    throw new BridgeError('FILESYSTEM_FAILURE', sanitiseError(error, [apiKey]), error);
  }
}

async function main() {
  const requestFile = process.argv[2];
  if (!requestFile) {
    console.error('Usage: npm run figure:generate -- docs/visual-requests/<request>.md');
    process.exitCode = 2;
    return;
  }
  const repoRoot = path.resolve(__dirname, '..');
  try {
    const result = await runBridge({ repoRoot, requestFile, env: process.env });
    console.log(`Generated ${result.record.requestId}`);
    console.log(`Source: ${relativeRepoPath(repoRoot, result.sourcePath)}`);
    console.log(`Production: ${relativeRepoPath(repoRoot, result.productionPath)}`);
    console.log(`Record: ${relativeRepoPath(repoRoot, result.recordPath)}`);
  } catch (error) {
    console.error(`Visual Asset Bridge failed [${error.code || 'UNKNOWN'}]: ${sanitiseError(error, [process.env.OPENAI_API_KEY])}`);
    process.exitCode = 1;
  }
}

module.exports = {
  BridgeError,
  REQUIRED_FRONTMATTER,
  REQUIRED_SECTIONS,
  parseFrontmatter,
  extractSections,
  parseDimensions,
  parseBudgetBytes,
  parseRequest,
  buildPrompt,
  chooseApiSize,
  isTransient,
  generateWithRetries,
  validateTargetAsset,
  validateRequestFile,
  decodeImageResponse,
  optimiseWebp,
  sanitiseError,
  runBridge
};

if (require.main === module) main();
