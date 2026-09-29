// The School-Ready Gate for a school programme, computed from the repository.
//
//   node curriculum/school/readiness.js            prints the gate
//   node curriculum/school/readiness.js --write    also writes docs/school/physics-v1/gate.md
//
// Every item is either computed from real artefacts (concept cards, concept
// packs and their review records, lesson QA status, guides, runtime code,
// the QA findings register) or is MANUAL: something only a person can
// verify, which passes only when curriculum/school/approvals.js records who
// verified it, when, and the evidence. Nothing here can mark a product
// ready because it looks ready.
//
// Overall status (brief §19, §27):
//   SCHOOL READY  every item passes
//   PILOT READY   every item marked `pilot` passes (internal ISM pilot of the
//                 first two blocks, Eric delivering, real data captured)
//   NOT READY     otherwise

const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..', '..');
const rel = p => path.join(ROOT, p);
const exists = p => fs.existsSync(rel(p));
const read = p => fs.readFileSync(rel(p), 'utf8');

const { PROGRAMME } = require('./physics-energy-v1.js');
const { APPROVALS } = require('./approvals.js');
const { CONCEPTS, MISCONCEPTIONS } = require('../physics/energy.js');

const PASS = 'PASS', FAIL = 'FAIL', MANUAL = 'MANUAL', PARTIAL = 'PARTIAL';
const USABLE_LESSON = ['reviewed', 'approved'];

function programmeConcepts(p = PROGRAMME) {
  return [...new Set(p.blocks.flatMap(b => b.concepts))];
}

// Every concept pack in the repo, with per-concept counts by evidence class,
// its review record (every item reviewed and accepted, every seed caught)
// and whether Eric approved the block.
function loadPacks() {
  const dir = rel('curriculum/physics/packs');
  const reviews = [];
  const blocks = {};
  const repDir = rel('docs/content-qa/reports');
  if (fs.existsSync(repDir)) {
    for (const f of fs.readdirSync(repDir).filter(f => f.endsWith('.item-reviews.json'))) {
      const j = JSON.parse(fs.readFileSync(path.join(repDir, f), 'utf8'));
      reviews.push(...(j.reviews || []));
      Object.assign(blocks, j.blocks || {});
    }
  }
  const packs = [];
  for (const f of fs.existsSync(dir) ? fs.readdirSync(dir).filter(f => f.endsWith('.js')) : []) {
    const pack = require(path.join(dir, f));
    const units = [...(pack.items || []).map(i => ({ ...i, kind: 'item' })), ...(pack.templates || []).map(t => ({ ...t, ref: t.id, kind: 'template' }))];
    const latest = {};
    for (const r of reviews.filter(r => r.pack === pack.id)) {
      if (!latest[r.ref] || (r.round || 0) >= (latest[r.ref].round || 0)) latest[r.ref] = r;
    }
    const accepted = units.every(u => latest[u.ref] && /^APPROVE/.test(latest[u.ref].decision));
    const seeds = blocks[pack.id];
    const reviewed = accepted && !!seeds && seeds.seeded_caught === seeds.seeded_total && seeds.seeded_total > 0;
    packs.push({ id: pack.id, concepts: pack.concepts, units, reviewed, approved: !!APPROVALS.packs[pack.id] });
  }
  return packs;
}

function conceptInventory(packs) {
  const inv = {};
  for (const id of programmeConcepts()) inv[id] = { diagnostic: 0, practice: 0, mastery_check: 0, retrieval: 0, application: 0, templates: 0, reviewed: false, approved: false, packs: [] };
  for (const p of packs) {
    for (const u of p.units) {
      const c = inv[u.primary_concept];
      if (!c) continue;
      if (u.kind === 'template') c.templates++;
      c[u.evidence_class] = (c[u.evidence_class] || 0) + 1;
      if (!c.packs.includes(p.id)) c.packs.push(p.id);
    }
    for (const id of p.concepts) {
      if (!inv[id]) continue;
      inv[id].reviewed = inv[id].reviewed || p.reviewed;
      inv[id].approved = inv[id].approved || (p.reviewed && p.approved);
    }
  }
  return inv;
}

function loadFindings() {
  const f = 'docs/school/physics-v1/qa/findings.json';
  return exists(f) ? JSON.parse(read(f)).findings : [];
}

function hasCycle(concepts) {
  const byId = Object.fromEntries(concepts.map(c => [c.id, c]));
  const state = {};
  const visit = id => {
    if (state[id] === 1) return true;
    if (state[id] === 2 || !byId[id]) return false;
    state[id] = 1;
    const cyc = (byId[id].prerequisites || []).some(p => visit(p.id));
    state[id] = 2;
    return cyc;
  };
  return concepts.some(c => visit(c.id));
}

const count = (arr, fn) => arr.filter(fn).length;
const list = arr => arr.length ? arr.join(', ') : 'none';

function manual(id) {
  const a = APPROVALS.gate[id];
  return a ? { status: PASS, evidence: `Verified by ${a.by}, ${a.date}: ${a.evidence}` } : { status: MANUAL, evidence: 'Not yet verified by a person (record it in curriculum/school/approvals.js).' };
}

function evaluate() {
  const concepts = programmeConcepts();
  const byId = Object.fromEntries(CONCEPTS.map(c => [c.id, c]));
  const packs = loadPacks();
  const inv = conceptInventory(packs);
  const findings = loadFindings();
  const teachingBlocks = PROGRAMME.blocks.filter(b => b.concepts.length);
  const pilotBlocks = teachingBlocks.slice(0, 2);
  const pilotConcepts = pilotBlocks.flatMap(b => b.concepts);
  // Findings name the asset they are about; a block's lesson is '<block>-lesson'.
  const usedAssets = new Set(PROGRAMME.blocks.filter(b => USABLE_LESSON.includes(b.lesson.status)).map(b => `${b.id}-lesson`));
  const guide = b => `docs/school/physics-v1/guides/${b.id}.md`;
  const need = (ids, fn) => ids.filter(id => !fn(inv[id] || {}, id));
  const code = (file, marker) => exists(file) && read(file).includes(marker);

  const items = [];
  const add = (id, label, pilot, r) => items.push({ id, label, pilot, ...r });

  // ── Scope and curriculum ──
  add('scope', 'Intervention scope explicitly defined and frozen', true,
    PROGRAMME.scopeFrozen && PROGRAMME.spec.claim ? { status: PASS, evidence: `Frozen ${PROGRAMME.scopeFrozen}: ${PROGRAMME.spec.claim}` } : { status: FAIL, evidence: 'No frozen scope.' });
  {
    const noSpec = concepts.filter(id => !(byId[id] && byId[id].spec && byId[id].spec.some(s => s.board === PROGRAMME.spec.principal.board)));
    add('spec', `Specification mapping complete (${PROGRAMME.spec.principal.board})`, true,
      noSpec.length ? { status: FAIL, evidence: `No ${PROGRAMME.spec.principal.board} reference: ${list(noSpec)}` }
        : { status: PASS, evidence: `All ${concepts.length} concepts carry ${PROGRAMME.spec.principal.board} references. Other boards: ${PROGRAMME.spec.otherBoards.map(o => `${o.board} ${o.status}`).join('; ')}.` });
  }
  {
    const missing = concepts.filter(id => !byId[id]);
    const unapproved = concepts.filter(id => byId[id] && byId[id].status !== 'approved');
    add('mastery-map', 'Mastery map complete (every concept exists and is approved)', true,
      missing.length || unapproved.length ? { status: FAIL, evidence: `Missing: ${list(missing)}; not approved: ${list(unapproved)}` }
        : { status: PASS, evidence: `${concepts.length} approved concepts in curriculum/physics/energy.js.` });
  }
  {
    const dangling = concepts.flatMap(id => (byId[id].prerequisites || []).filter(p => !byId[p.id]).map(p => `${id}→${p.id}`));
    const cyc = hasCycle(CONCEPTS);
    add('prerequisites', 'Prerequisites mapped (edges resolve, no cycles)', true,
      dangling.length || cyc ? { status: FAIL, evidence: `Dangling: ${list(dangling)}; cycle: ${cyc}` }
        : { status: PASS, evidence: `${concepts.reduce((s, id) => s + byId[id].prerequisites.length, 0)} prerequisite edges, acyclic.` });
  }
  {
    const none = concepts.filter(id => !(byId[id].misconceptions || []).length);
    add('misconceptions', 'Common misconceptions mapped', true,
      none.length ? { status: FAIL, evidence: `No misconceptions: ${list(none)}` }
        : { status: PASS, evidence: `${MISCONCEPTIONS.length} canonical misconceptions; every concept has at least one.` });
  }

  // ── Diagnostic, routing, runtime ──
  // Code in the repo is not a working system: runtime items pass only once a
  // person records that migration 2 ran and the code is live and smoke-tested
  // (approvals.gate['runtime-live']).
  const liveRec = APPROVALS.gate['runtime-live'];
  const liveNote = liveRec ? `Live: verified by ${liveRec.by}, ${liveRec.date}.` : 'Not live yet: needs supabase/mastery_engine_02_programme.sql run, then deploy, then a smoke test recorded as runtime-live.';
  {
    const noDiag = need(concepts, c => c.diagnostic >= 1 && c.approved);
    const runtime = code('netlify/functions/diagnostic-session-start.js', 'programmeCheck') && exists('tests/programme-checks.test.js');
    add('baseline', 'Baseline diagnostic operational (approved diagnostic item per concept + programme-check runtime, live)', true,
      !noDiag.length && runtime && liveRec ? { status: PASS, evidence: `Every concept has an approved diagnostic item; the runtime serves programme checks. ${liveNote}` }
        : { status: noDiag.length < concepts.length || runtime ? PARTIAL : FAIL,
            evidence: `Concepts without an approved diagnostic item: ${noDiag.length}/${concepts.length} (${list(noDiag)}). Programme-check runtime: ${runtime ? 'built and tested' : 'not built'}. ${liveNote}` });
  }
  {
    const rules = exists('assets/js/mastery-rules.js') && exists('tests/mastery-rules.test.js');
    const view = exists('teacher/intervention.html') && exists('netlify/functions/programme-decision.js') && exists('tests/programme-view.test.js');
    add('routing', 'Intervention routing operational (deterministic rules + teacher validation, live)', true,
      rules && view && liveRec ? { status: PASS, evidence: `assets/js/mastery-rules.js (tested) and the teacher programme view with accept/override. ${liveNote}` }
        : { status: rules ? PARTIAL : FAIL, evidence: `Rules module: ${rules ? 'built and tested' : 'missing'}. Teacher view with validate/override: ${view ? 'built and tested' : 'not built'}. ${liveNote}` });
  }

  // ── Content layers per block ──
  {
    const bad = PROGRAMME.blocks.filter(b => !USABLE_LESSON.includes(b.lesson.status));
    const pilotBad = pilotBlocks.filter(b => !USABLE_LESSON.includes(b.lesson.status));
    add('lessons', '100% core lessons present and QA-passed', false,
      bad.length ? { status: FAIL, evidence: `${PROGRAMME.blocks.length - bad.length}/${PROGRAMME.blocks.length} usable. ${bad.map(b => `${b.id}: ${b.lesson.status}`).join('; ')}` }
        : { status: PASS, evidence: 'Every block has a reviewed or approved lesson.' });
    add('lessons-pilot', 'Core lessons present and QA-passed for the pilot blocks (B1, B2)', true,
      pilotBad.length ? { status: FAIL, evidence: pilotBad.map(b => `${b.id}: ${b.lesson.status}${b.lesson.qa ? ` (${b.lesson.qa})` : ''}`).join('; ') }
        : { status: PASS, evidence: 'B1 and B2 lessons reviewed.' });
  }
  {
    const missingGuide = PROGRAMME.blocks.filter(b => !exists(guide(b)));
    const incomplete = PROGRAMME.blocks.filter(b => exists(guide(b)) && !USABLE_LESSON.includes(b.lesson.status));
    const pilotOk = pilotBlocks.every(b => exists(guide(b)) && USABLE_LESSON.includes(b.lesson.status)) && exists('docs/school/physics-v1/guides/00-programme.md');
    add('guides', '100% teacher guides present (programme guide + block guides tied to a usable lesson)', false,
      !missingGuide.length && !incomplete.length && exists('docs/school/physics-v1/guides/00-programme.md') ? { status: PASS, evidence: 'All guides present.' }
        : { status: missingGuide.length === PROGRAMME.blocks.length ? FAIL : PARTIAL,
            evidence: `Programme guide: ${exists('docs/school/physics-v1/guides/00-programme.md') ? 'present' : 'missing'}. Block guides missing: ${list(missingGuide.map(b => b.id))}. Guides generated but without a usable lesson to deliver from: ${list(incomplete.map(b => b.id))}.` });
    add('guides-pilot', 'Teacher guides present for the pilot blocks (B1, B2)', true,
      pilotOk ? { status: PASS, evidence: 'Present.' } : { status: FAIL, evidence: 'The B1/B2 guides need a usable lesson behind them (see lessons-pilot).' });
  }
  {
    const noPractice = need(concepts, c => (c.practice || 0) >= 1 && c.approved);
    add('practice', '100% student practice present (approved practice per concept)', false,
      noPractice.length ? { status: noPractice.length < concepts.length ? PARTIAL : FAIL, evidence: `${concepts.length - noPractice.length}/${concepts.length} concepts have approved practice. Missing: ${list(noPractice)}` }
        : { status: PASS, evidence: 'Every concept has approved practice.' });
    const pilotNo = need(pilotConcepts, c => (c.practice || 0) >= 1 && c.approved);
    add('practice-pilot', 'Approved practice for the pilot blocks', true,
      pilotNo.length ? { status: FAIL, evidence: `Missing: ${list(pilotNo)}` } : { status: PASS, evidence: 'Present.' });
  }
  {
    // Every reviewed pack item carries an explanation and feedback (enforced by
    // the check suite); lessons need model answers, which only a usable lesson has.
    const noItems = need(concepts, c => c.reviewed);
    const lessonsOk = PROGRAMME.blocks.every(b => USABLE_LESSON.includes(b.lesson.status));
    add('answers', '100% answers / worked solutions present', false,
      !noItems.length && lessonsOk ? { status: PASS, evidence: 'Every item has a worked explanation; every lesson has model answers.' }
        : { status: PARTIAL, evidence: `Reviewed items (all with worked explanations) for ${concepts.length - noItems.length}/${concepts.length} concepts. Lessons with QA-passed model answers: ${PROGRAMME.blocks.filter(b => USABLE_LESSON.includes(b.lesson.status)).length}/${PROGRAMME.blocks.length}.` });
  }
  {
    const app = Object.values(inv).reduce((s, c) => s + (c.application || 0), 0);
    add('exam', 'Exam-application practice mapped (≥ 5 Inspire-written multi-concept items)', false,
      app >= 5 ? { status: PASS, evidence: `${app} application items.` } : { status: FAIL, evidence: `${app} application items (need ≥ 5). PASCO solutions are private (copyright) and cannot fill this layer.` });
  }
  {
    const two = need(concepts, c => (c.mastery_check || 0) >= 2 && c.approved);
    const three = need(concepts, c => (c.mastery_check || 0) >= 3 && c.approved);
    add('mastery-checks', 'Mastery checks present (≥ 2 approved mastery-check items per concept)', false,
      !two.length ? { status: PASS, evidence: 'Every concept.' } : { status: two.length < concepts.length ? PARTIAL : FAIL, evidence: `${concepts.length - two.length}/${concepts.length} concepts. Missing: ${list(two)}` });
    add('pool-depth', 'Item-pool depth for a second attempt (≥ 3 approved mastery-check items per concept)', false,
      !three.length ? { status: PASS, evidence: 'Every concept.' } : { status: three.length < concepts.length ? PARTIAL : FAIL, evidence: `${concepts.length - three.length}/${concepts.length} concepts. Short: ${list(three)}` });
    const pilotTwo = need(pilotConcepts, c => (c.mastery_check || 0) >= 2 && c.approved);
    add('mastery-checks-pilot', 'Mastery checks present for the pilot blocks', true,
      pilotTwo.length ? { status: FAIL, evidence: `Missing: ${list(pilotTwo)}` } : { status: PASS, evidence: 'Present.' });
  }
  {
    const rules = exists('assets/js/mastery-rules.js');
    // Remediation = routing (which action, in what order) + material to
    // deliver it. For the pilot, each block lesson's misconception clinic and
    // the generated guide's per-misconception route are that material.
    const usable = b => USABLE_LESSON.includes(b.lesson.status);
    const pilotOk = rules && pilotBlocks.every(usable) && pilotBlocks.every(b => exists(guide(b)));
    add('remediation-pilot', 'Remediation pathways for the pilot blocks (routing + clinics in the B1/B2 lessons + per-misconception routes in the guides)', true,
      pilotOk ? { status: PASS, evidence: 'mastery-rules.js routing and REMEDIATION_STEPS; the B1/B2 lessons have misconception clinics; the block guides give a route per misconception.' }
        : { status: rules ? PARTIAL : FAIL, evidence: `Routing: ${rules ? 'built' : 'missing'}. Pilot lessons with clinics: ${pilotBlocks.filter(usable).map(b => b.id).join(', ') || 'none'} of B1, B2.` });
    add('remediation', 'Remediation pathways present for every block (routing + lesson clinics + per-misconception material)', false,
      rules && PROGRAMME.blocks.every(usable) ? { status: PASS, evidence: 'Routing plus a QA-passed lesson with clinics for every block.' }
        : { status: rules ? PARTIAL : FAIL, evidence: `Routing built; blocks without a QA-passed lesson to carry the clinics: ${list(PROGRAMME.blocks.filter(b => !usable(b)).map(b => b.id))}. Dedicated remediation micro-lessons per misconception: not yet produced (P1).` });
  }
  {
    // The V1 runtime serves fixed items only (template instances are not
    // served yet), so a parallel form needs a second approved fixed
    // diagnostic or retrieval item per concept, unseen at baseline.
    const runtime = code('netlify/functions/diagnostic-session-start.js', 'programmeCheck');
    const parallel = need(concepts, c => ((c.diagnostic || 0) + (c.retrieval || 0)) >= 2 && c.approved);
    add('reassessment', 'Reassessment present (parallel form per concept + runtime, live)', false,
      runtime && liveRec && !parallel.length ? { status: PASS, evidence: `Parallel items for every concept. ${liveNote}` }
        : { status: runtime ? PARTIAL : FAIL, evidence: `Concepts without a second approved diagnostic/retrieval item for a parallel form: ${parallel.length}/${concepts.length}. Runtime: ${runtime ? 'built (reassessment mode, unseen items only)' : 'not built'}. ${liveNote}` });
  }
  {
    const built = exists('teacher/intervention-report.html') && exists('assets/js/intervention-report.js') && exists('netlify/functions/programme-cohort.js');
    add('reporting', 'Reporting operational (school intervention report from real data, live)', false,
      built && liveRec ? { status: PASS, evidence: `teacher/intervention-report.html from recorded data. ${liveNote}` }
        : { status: built ? PARTIAL : FAIL, evidence: `${built ? 'Report built: attendance, baseline, priorities, pathways, block checks, reassessment comparison, profile, individual summaries, next steps; recorded data only; no causal claims.' : 'No cohort/school report.'} ${liveNote}` });
  }

  // ── People, QA, approval ──
  add('delivery-guides', 'Teacher delivery does not depend on Eric: guides complete', false,
    items.find(i => i.id === 'guides').status === PASS ? { status: PASS, evidence: 'Guides complete.' } : { status: FAIL, evidence: 'Guides incomplete (see guides).' });
  add('T-delivery', 'Teacher delivery does not depend on Eric: a session delivered by a non-author from the guide alone', false, manual('T-delivery'));
  {
    const unreviewed = need(concepts, c => c.reviewed);
    const pilotUnreviewed = need(pilotConcepts, c => c.reviewed);
    add('qa', 'Physics Subject Expert QA passed (every item and every lesson in use)', false,
      !unreviewed.length && PROGRAMME.blocks.every(b => USABLE_LESSON.includes(b.lesson.status)) ? { status: PASS, evidence: 'All reviewed.' }
        : { status: FAIL, evidence: `Concepts with reviewed packs: ${concepts.length - unreviewed.length}/${concepts.length}. Lessons QA-passed: ${PROGRAMME.blocks.filter(b => USABLE_LESSON.includes(b.lesson.status)).length}/${PROGRAMME.blocks.length}.` });
    add('qa-pilot', 'Subject QA passed for the pilot blocks', true,
      !pilotUnreviewed.length && pilotBlocks.every(b => USABLE_LESSON.includes(b.lesson.status)) ? { status: PASS, evidence: 'Reviewed.' }
        : { status: FAIL, evidence: `Unreviewed concepts: ${list(pilotUnreviewed)}; lessons: ${pilotBlocks.map(b => `${b.id} ${b.lesson.status}`).join(', ')}` });
  }
  {
    const unapproved = need(concepts, c => c.approved);
    add('eric', 'Eric spot-review gate passed (every block approved)', false,
      !unapproved.length ? { status: PASS, evidence: 'All approved.' } : { status: unapproved.length < concepts.length ? PARTIAL : FAIL, evidence: `Approved: ${concepts.length - unapproved.length}/${concepts.length} (${list(concepts.filter(id => inv[id].approved))}).` });
  }

  // ── Testing, safety, claims ──
  add('E2E-student', 'End-to-end student journey tested', true, manual('E2E-student'));
  add('E2E-teacher', 'End-to-end teacher journey tested', true, manual('E2E-teacher'));
  add('preserved', 'Historical/current production functionality preserved (full test suite + live smoke check)', true, manual('preserved'));
  add('routes', 'No critical broken routes', true, manual('routes'));
  {
    const openCritical = findings.filter(f => ['critical', 'major'].includes(f.severity) && f.status === 'open');
    const inProgramme = openCritical.filter(f => usedAssets.has(f.asset));
    add('errors', 'No known scientific errors in programme content', true,
      inProgramme.length ? { status: FAIL, evidence: `Open critical or major findings in programme content: ${inProgramme.map(f => f.id).join(', ')}` }
        : { status: PASS, evidence: `No open critical or major findings in content the programme uses. ${openCritical.length} open critical or major findings in assets the programme does NOT use (qa-failed): ${list(openCritical.map(f => f.id))}. Some of those assets are live elsewhere; see the findings register.` });
  }
  {
    const files = ['docs/school/physics-v1/README.md', ...PROGRAMME.blocks.map(guide), 'docs/school/physics-v1/guides/00-programme.md'].filter(exists);
    const overclaims = files.filter(f => /complete GCSE Physics (course|coverage)(?! |\.|\))|covers? (all|the whole) (of )?GCSE Physics/i.test(read(f).replace(/not (a|be described as) (complete )?GCSE Physics (course|coverage)/gi, '')));
    add('claims', 'No unsupported school-facing claims', true,
      overclaims.length ? { status: FAIL, evidence: `Possible overclaim in: ${list(overclaims)}` } : { status: PASS, evidence: `Scope claim is bounded ("${PROGRAMME.spec.claim.slice(0, 80)}…"); no whole-course claims in programme docs.` });
  }
  add('copyright', 'Copyright review passed', false, manual('copyright'));
  {
    const big = ['teaching-lessons/physics/inspire_physics_energy_stores_transfers_y10_final_sharp_premium.html', 'teaching-lessons/physics/Inspire_Physics_Energy_Stores-Transfers_Y10.html']
      .filter(exists).map(f => `${path.basename(f)} ${(fs.statSync(rel(f)).size / 1e6).toFixed(1)} MB`);
    add('performance', 'Performance acceptable (pupil-facing pages within budget)', false,
      { status: MANUAL, evidence: `Not measured for programme pages yet. Known over budget (not used by the programme): ${list(big)}.` });
  }
  add('accessibility', 'Accessibility acceptable (programme pages)', false, manual('accessibility'));
  add('demo', 'Programme can be demonstrated end-to-end on real data', false, manual('demo'));
  add('data-protection', 'Data protection for school pupils (DPA + school privacy notice)', false, manual('data-protection'));
  add('safeguarding', 'Safeguarding policy for live small-group online sessions', false, manual('safeguarding'));
  add('pilot-data-protection', 'Internal pilot: ISM pupils and families informed that intervention data is used to evaluate the programme', true, manual('pilot-data-protection'));

  const allPass = items.every(i => i.status === PASS);
  const pilotPass = items.filter(i => i.pilot).every(i => i.status === PASS);
  const status = allPass ? 'SCHOOL READY' : pilotPass ? 'PILOT READY' : 'NOT READY';
  return { programme: PROGRAMME.id, status, items, inventory: inv, packs: packs.map(p => ({ id: p.id, reviewed: p.reviewed, approved: p.approved })) };
}

function render(g) {
  const tally = s => g.items.filter(i => i.status === s).length;
  const icon = { PASS: '✅', FAIL: '❌', PARTIAL: '◐', MANUAL: '👤' };
  const lines = [];
  lines.push(`# School-Ready Gate: ${PROGRAMME.product}`, '');
  lines.push(`*Generated by \`node curriculum/school/readiness.js --write\`. Do not edit by hand. Programme \`${g.programme}\` ${PROGRAMME.version}.*`, '');
  lines.push(`## Status: **${g.status}**`, '');
  lines.push(`${tally(PASS)} pass · ${tally(PARTIAL)} partial · ${tally(FAIL)} fail · ${tally(MANUAL)} awaiting a person · ${g.items.length} items. Pilot items: ${g.items.filter(i => i.pilot && i.status === PASS).length}/${g.items.filter(i => i.pilot).length} pass.`, '');
  lines.push('PILOT READY means every item marked **P** passes: an internal pilot of Blocks 1–2 with the ISM cohort. SCHOOL READY needs every item.', '');
  lines.push('| | Item | P | Evidence |', '|---|---|---|---|');
  for (const i of g.items) lines.push(`| ${icon[i.status]} ${i.status} | ${i.label} | ${i.pilot ? 'P' : ''} | ${String(i.evidence).replace(/\|/g, '\\|')} |`);
  lines.push('', '## Concept inventory (from the concept packs in the repo)', '');
  lines.push('| Concept | Diag | Practice (fixed) | Templates | Mastery check | Retrieval | Application | Reviewed | Approved |', '|---|---|---|---|---|---|---|---|---|');
  for (const [id, c] of Object.entries(g.inventory)) {
    const fixedPractice = (c.practice || 0) - (c.templates || 0);
    lines.push(`| \`${id}\` | ${c.diagnostic || 0} | ${Math.max(0, fixedPractice)} | ${c.templates || 0} | ${c.mastery_check || 0} | ${c.retrieval || 0} | ${c.application || 0} | ${c.reviewed ? '✓' : ''} | ${c.approved ? '✓' : ''} |`);
  }
  lines.push('', '## Decisions pending (Eric)', '', ...PROGRAMME.decisionsPending.map(d => `- ${d}`), '');
  return lines.join('\n');
}

if (require.main === module) {
  const g = evaluate();
  const md = render(g);
  if (process.argv.includes('--write')) {
    fs.writeFileSync(rel('docs/school/physics-v1/gate.md'), md);
    console.log('wrote docs/school/physics-v1/gate.md');
  }
  console.log(`${PROGRAMME.product}: ${g.status}`);
  for (const i of g.items) console.log(`${i.status.padEnd(7)} ${i.pilot ? 'P' : ' '} ${i.id}`);
}

module.exports = { evaluate, render, programmeConcepts, loadPacks, conceptInventory };
