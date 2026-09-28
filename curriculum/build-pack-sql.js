// Compiles a reviewed concept pack to the SQL that loads it as a content
// block ready for the human spot check:
//
//   node curriculum/build-pack-sql.js phy-energy-kinetic-01
//
// writes supabase/pack_phy-energy-kinetic-01.sql. Generated; a test checks
// it is current. Requires mastery_engine_01 and the curriculum SQL first.
//
// It refuses unless the pack is ready: it passes its automated checks, every
// item and template has a latest subject review of APPROVE or
// APPROVE_WITH_CORRECTIONS, and the reviewer caught every seed in the
// block's batches. Review records come from
// docs/content-qa/reports/*.item-reviews.json.
//
// What the SQL writes:
//   content_blocks       the block, status ready_for_sampling, with its seed
//                        results (the spot check is drawn by
//                        draw_block_sample() on the Content QA page)
//   diagnostic_questions each fixed item as a draft (review_status 'draft',
//                        pipeline_stage 'in_block', its evidence_class): never
//                        served, and not approvable on its own
//   item_templates       each template, the whole definition in parameters
//   item_concepts, item_option_misconceptions, item_auto_checks, item_reviews
//
// Safe to re-run: existing rows are found by block and question text (items)
// or id (templates); tags and check results are replaced; review rows are
// added once. Items already approved are never touched.
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { run } = require('./check-pack.js');

const ROOT = path.join(__dirname, '..');
const KEYS = ['a', 'b', 'c', 'd'];

// Where each concept's fixed items sit in the diagnostic bank's own labels.
const BANK_TAGS = {
  'phy.energy.kinetic': ['Energy Stores & Transfers', 'Kinetic Energy', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.gravitational': ['Energy Stores & Transfers', 'Gravitational Potential Energy', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.elastic': ['Energy Stores & Transfers', 'Elastic Potential Energy', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.stores-systems': ['Energy Stores & Transfers', 'Energy Stores', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.conservation': ['Energy Stores & Transfers', 'Energy Transfers', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.transfer-calcs': ['Energy Stores & Transfers', 'Energy Transfers', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.shc': ['Energy Stores & Transfers', 'Specific Heat Capacity', 'aqa-ph-fh-energy-stores-transfers'],
  'phy.energy.power': ['Energy Stores & Transfers', 'Power', 'aqa-ph-fh-energy-efficiency'],
  'phy.energy.dissipation-efficiency': ['Energy Stores & Transfers', 'Efficiency', 'aqa-ph-fh-energy-efficiency'],
  'phy.energy.resources': ['Energy Stores & Transfers', 'Energy Resources', 'aqa-ph-fh-energy-resources'],
  'phy.forces.work-done': ['Energy Stores & Transfers', 'Work Done', 'aqa-ph-fh-forces-work-energy']
};
// Difficulty band -> the bank's 1–5 difficulty (evidence-classes.md maps 1–2 -> 1, 3 -> 2, 4–5 -> 3).
const BAND_TO_DIFFICULTY = { 1: 2, 2: 3, 3: 4 };

const q = v => {
  if (v === null || v === undefined) return 'null';
  const s = String(v);
  if (s.includes('$t$')) throw new Error('text contains $t$');
  return `$t$${s}$t$`;
};
const json = v => `${q(JSON.stringify(v))}::jsonb`;
const arr = xs => (xs && xs.length ? `array[${xs.map(q).join(', ')}]::text[]` : `'{}'::text[]`);

function reviewsFor(packId) {
  const dir = path.join(ROOT, 'docs', 'content-qa', 'reports');
  const out = { reviews: new Map(), block: null, meta: null };
  for (const f of fs.readdirSync(dir).filter(f => f.endsWith('.item-reviews.json'))) {
    const rec = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
    for (const r of rec.reviews.filter(r => r.pack === packId)) {
      const prev = out.reviews.get(r.ref);
      if (!prev || r.round > prev.round) out.reviews.set(r.ref, { ...r, file: f });
    }
    if (rec.blocks && rec.blocks[packId]) { out.block = rec.blocks[packId]; out.meta = rec; }
  }
  return out;
}

const mapping = m => (/^slip\b/i.test(String(m)) ? { mis: null, slip: String(m).replace(/^slip\b:?\s*/i, '') } : { mis: m, slip: null });

function itemSql(pack, x, check, review, meta, commit) {
  const [topic, subtopic, slug] = BANK_TAGS[x.primary_concept] || [];
  if (!topic) throw new Error(`${x.ref}: no bank topic for ${x.primary_concept}`);
  const numeric = x.format === 'numeric';
  const o = x.options || {};
  const feedback = KEYS.map(k => q(numeric || k === x.key ? null : (x.feedback || {})[k]));
  const L = [];
  L.push(`-- ${x.ref} (${x.evidence_class}, band ${x.difficulty_band})`);
  L.push('do $$ declare v_id bigint; begin');
  L.push(`  select id into v_id from public.diagnostic_questions where block_id = ${q(pack.id)} and question_text = ${q(x.question_text)};`);
  L.push('  if v_id is null then');
  L.push(`    insert into public.diagnostic_questions (
      subject, exam_board, level, tier, topic, subtopic, spec_slug, difficulty,
      question_text, option_a, option_b, option_c, option_d, option_e, correct_answer,
      misconception_a, misconception_b, misconception_c, misconception_d, explanation,
      source, validated, active, review_status, question_type, answer_spec, combined_eligible,
      evidence_class, block_id, pipeline_stage, drafted_by, draft_ref, marks)
    values (${q(pack.subject)}, ${q(x.exam_board || 'Universal')}, 'GCSE', ${q(x.tier)}, ${q(topic)}, ${q(subtopic)}, ${q(slug)}, ${BAND_TO_DIFFICULTY[x.difficulty_band]},
      ${q(x.question_text)}, ${q(o.a)}, ${q(o.b)}, ${q(o.c)}, ${q(o.d)}, 'Not sure', ${q(numeric ? null : x.key)},
      ${feedback.join(', ')}, ${q(x.explanation)},
      'ai_drafted', false, true, 'draft', ${q(numeric ? 'numeric' : 'mcq')}, ${numeric ? json(x.answer) : 'null'}, ${x.separate_only ? 'false' : 'true'},
      ${q(x.evidence_class)}, ${q(pack.id)}, 'in_block', ${q(pack.drafted_by)}, ${q(commit)}, ${x.marks == null ? 'null' : Number(x.marks)})
    returning id into v_id;`);
  L.push('  end if;');
  L.push(`  if (select review_status from public.diagnostic_questions where id = v_id) <> 'approved' then`);
  L.push(...tagSql("'diagnostic'", 'v_id::text', x, '    '));
  L.push(...evidenceSql("'diagnostic'", 'v_id::text', pack, check, review, meta, '    '));
  L.push('  end if;');
  L.push('end $$;');
  return L.join('\n');
}

function tagSql(src, id, x, ind) {
  const L = [];
  L.push(`${ind}delete from public.item_concepts where item_source = ${src} and item_id = ${id};`);
  L.push(`${ind}insert into public.item_concepts (item_source, item_id, concept_id, role, evidence_class, difficulty_band, format, context_tags, separate_only)`);
  L.push(`${ind}values (${src}, ${id}, ${q(x.primary_concept)}, 'primary', ${q(x.evidence_class)}, ${x.difficulty_band}, ${q(x.format)}, ${arr(x.context_tags)}, ${x.separate_only ? 'true' : 'false'});`);
  if (x.secondary_concept) {
    L.push(`${ind}insert into public.item_concepts (item_source, item_id, concept_id, role, evidence_class, difficulty_band, format, context_tags, separate_only)`);
    L.push(`${ind}values (${src}, ${id}, ${q(x.secondary_concept)}, 'secondary', ${q(x.evidence_class)}, ${x.difficulty_band}, ${q(x.format)}, ${arr(x.context_tags)}, ${x.separate_only ? 'true' : 'false'});`);
  }
  L.push(`${ind}delete from public.item_option_misconceptions where item_source = ${src} and item_id = ${id};`);
  for (const [opt, m] of Object.entries(x.misconception_map || {})) {
    const { mis, slip } = mapping(m);
    L.push(`${ind}insert into public.item_option_misconceptions (item_source, item_id, option, misconception_id, slip) values (${src}, ${id}, ${q(opt)}, ${q(mis)}, ${q(slip)});`);
  }
  return L;
}

function evidenceSql(src, id, pack, check, review, meta, ind) {
  const L = [];
  const results = { checks: check.checks, ...(check.samples ? { samples: check.samples, instances_checked: check.instances_checked } : {}) };
  L.push(`${ind}delete from public.item_auto_checks where item_source = ${src} and item_id = ${id} and suite_version = ${q(check.suite_version)};`);
  L.push(`${ind}insert into public.item_auto_checks (item_source, item_id, suite_version, passed, results) values (${src}, ${id}, ${q(check.suite_version)}, ${check.passed}, ${json(results)});`);
  L.push(`${ind}insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, blind_solve, second_solver, key_matches, criteria, decision, corrections, reason)`);
  L.push(`${ind}select ${src}, ${id}, ${q(pack.id)}, ${q(meta.reviewer)}, ${q(meta.reviewer_version)}, ${meta.rubric_version}, ${q(meta.reference_pack_commit)}, ${q(review.blind_solve)}, ${q(review.second_solver || null)}, ${review.key_matches}, ${json(review.criteria)}, ${q(review.decision)}, ${json(review.corrections || [])}, ${q(review.reason || null)}`);
  L.push(`${ind} where not exists (select 1 from public.item_reviews where item_source = ${src} and item_id = ${id} and reviewer_version = ${q(meta.reviewer_version)} and decision = ${q(review.decision)} and blind_solve = ${q(review.blind_solve)});`);
  return L;
}

function templateSql(pack, t, check, review, meta, commit) {
  const id = `${pack.id}/${t.id}`;
  const L = [];
  const rules = (t.calc.wrong || []).map(rule => ({ rule, misconception: (t.misconception_map || {})[rule], feedback: (t.feedback || {})[rule] }));
  L.push(`-- template ${id} (${t.evidence_class}, band ${t.difficulty_band})`);
  L.push('do $$ begin');
  L.push(`  if not exists (select 1 from public.item_templates where id = ${q(id)} and review_status = 'approved') then`);
  L.push(`    insert into public.item_templates (id, concept_id, evidence_class, stem, parameters, answer_formula, distractor_rules, tolerance, generator, block_id, pipeline_stage, drafted_by)`);
  L.push(`    values (${q(id)}, ${q(t.primary_concept)}, ${q(t.evidence_class)}, ${q(t.stem)}, ${json(t)}, ${q(`${t.calc.formula} -> ${t.calc.unit || '(no unit)'}`)}, ${json(rules)}, ${t.tolerance || 0.01}, ${q(`curriculum/templates.js@${commit}`)}, ${q(pack.id)}, 'in_block', ${q(pack.drafted_by)})`);
  L.push(`    on conflict (id) do update set concept_id = excluded.concept_id, evidence_class = excluded.evidence_class, stem = excluded.stem, parameters = excluded.parameters, answer_formula = excluded.answer_formula, distractor_rules = excluded.distractor_rules, tolerance = excluded.tolerance, generator = excluded.generator, block_id = excluded.block_id, pipeline_stage = excluded.pipeline_stage, drafted_by = excluded.drafted_by;`);
  const x = { ...t, misconception_map: Object.fromEntries(rules.map(r => [r.rule, r.misconception])) };
  L.push(...tagSql("'template'", q(id), x, '    '));
  L.push(...evidenceSql("'template'", q(id), pack, check, review, meta, '    '));
  L.push('  end if;');
  L.push('end $$;');
  return L.join('\n');
}

function build(packId, argv = []) {
  const { report } = run(packId, argv);
  if (!report.passed) throw new Error(`${packId} does not pass its automated checks`);
  const pack = require(path.join(__dirname, report.subject.toLowerCase(), 'packs', packId + '.js'));
  const { reviews, block, meta } = reviewsFor(packId);
  if (!block || !meta) throw new Error(`${packId}: no review record (docs/content-qa/reports/*.item-reviews.json)`);
  if (block.seeded_caught < block.seeded_total) throw new Error(`${packId}: the reviewer missed ${block.seeded_total - block.seeded_caught} seed(s)`);
  const refs = [...pack.items.map(i => i.ref), ...pack.templates.map(t => t.id)];
  for (const ref of refs) {
    const r = reviews.get(ref);
    if (!r) throw new Error(`${packId}: ${ref} has no subject review`);
    if (!['APPROVE', 'APPROVE_WITH_CORRECTIONS'].includes(r.decision)) throw new Error(`${packId}: ${ref}'s latest review is ${r.decision}`);
  }
  let commit = 'uncommitted';
  try { commit = execSync(`git log -1 --format=%h -- "${path.relative(ROOT, path.join(__dirname, report.subject.toLowerCase(), 'packs', packId + '.js'))}"`, { cwd: ROOT, stdio: ['ignore', 'pipe', 'ignore'] }).toString().trim() || commit; } catch { /* keep */ }
  const checkOf = ref => ({ ...report.items.find(i => i.ref === ref), suite_version: report.suite_version });

  const out = [];
  out.push(`-- Content block ${pack.id}: ${pack.items.length} items and ${pack.templates.length} templates for ${pack.concepts.join(', ')}.`);
  out.push(`-- GENERATED by curriculum/build-pack-sql.js from curriculum/${report.subject.toLowerCase()}/packs/${pack.id}.js`);
  out.push('-- and its review record. Do not edit; regenerate.');
  out.push('--');
  out.push(`-- Loads the block as drafts, ready for the spot check: nothing here is served`);
  out.push(`-- or approved. Approval happens only on the Content QA page (draw the sample,`);
  out.push(`-- check it, approve), by a signed-in admin.`);
  out.push('-- Needs mastery_engine_01 and curriculum_physics_energy.sql first. Safe to re-run.');
  out.push('--');
  out.push('-- Run in the LIVE project only:');
  out.push('-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new');
  out.push('');
  out.push('begin;');
  out.push('');
  out.push(`insert into public.content_blocks (id, subject, concept_ids, status, reviewer_version, seeded_total, seeded_caught)`);
  out.push(`values (${q(pack.id)}, ${q(pack.subject)}, ${arr(pack.concepts)}, 'ready_for_sampling', ${q(meta.reviewer_version)}, ${block.seeded_total}, ${block.seeded_caught})`);
  out.push(`on conflict (id) do update set concept_ids = excluded.concept_ids, reviewer_version = excluded.reviewer_version, seeded_total = excluded.seeded_total, seeded_caught = excluded.seeded_caught,`);
  out.push(`  status = case when content_blocks.status in ('open', 'returned') then 'ready_for_sampling' else content_blocks.status end, updated_at = now();`);
  out.push('');
  const secondSolver = (meta.second_solver || {})[pack.id] || {};
  for (const x of pack.items) out.push(itemSql(pack, x, checkOf(x.ref), { ...reviews.get(x.ref), second_solver: secondSolver[x.ref] }, meta, commit), '');
  for (const t of pack.templates) out.push(templateSql(pack, t, checkOf(t.id), reviews.get(t.id), meta, commit), '');
  out.push('commit;');
  out.push('');
  out.push(`-- Check. Expected: block ready_for_sampling (${block.seeded_caught}/${block.seeded_total} seeds caught), ${pack.items.length} draft items, ${pack.templates.length} templates, ${refs.length} with an accepted review.`);
  out.push(`select b.status, b.seeded_caught || '/' || b.seeded_total as seeds,`);
  out.push(`       (select count(*) from public.diagnostic_questions where block_id = b.id and review_status = 'draft') as draft_items,`);
  out.push(`       (select count(*) from public.item_templates where block_id = b.id) as templates,`);
  out.push(`       (select count(distinct r.item_id) from public.item_reviews r where r.block_id = b.id and r.decision in ('APPROVE', 'APPROVE_WITH_CORRECTIONS')) as reviewed`);
  out.push(`  from public.content_blocks b where b.id = ${q(pack.id)};`);
  out.push('');
  return out.join('\n');
}

if (require.main === module) {
  const [packId, ...argv] = process.argv.slice(2);
  if (!packId) { console.error('usage: node curriculum/build-pack-sql.js <pack>'); process.exit(2); }
  const dest = path.join(ROOT, 'supabase', `pack_${packId}.sql`);
  fs.writeFileSync(dest, build(packId, argv));
  console.log(`wrote ${path.relative(ROOT, dest)}`);
}

module.exports = { build, BANK_TAGS };
