// _tutor-academy-confidential.js — Tutor Academy assessor-only content
// (mark-scheme keys, rubrics, calibration keys). This file is never
// bundled into or served to the browser — it's required only by
// netlify/functions/get-tutor-academy-assessor-content.js, which is
// itself gated to admin/assessor callers. See that function's header
// comment for why this can't live in a client-loaded assets/js/
// registry the way the rest of the Tutor Academy content does.
//
// Source: IBTAEP Pack 01, Part I (Assessor Section, Confidential),
// resources/tutor-academy/biology-gcse/01_IBTAEP_Pack_01_...docx.
// Transcribed faithfully — see CLAUDE.md-equivalent build brief
// Section 30, "do not silently weaken requirements."

const STAGE_1 = {
  'gcse-diagnostic-marking-guide': {
    title: 'GCSE Diagnostic Marking Guide (Part B)',
    items: [
      { q: '1(a)', guide: '600×. Convert 36 mm to 36,000 μm; magnification = image/actual = 36,000/60. Award method, conversion, answer.' },
      { q: '1(b)', guide: 'Higher SA:V means more membrane area per unit volume; shorter effective exchange distances / exchange can meet cellular demand faster; accept correctly linked explanation.' },
      { q: '2', guide: 'Net movement of water molecules from a region of higher water concentration (or higher water potential) to lower water concentration through a partially permeable membrane. GCSE wording may use dilute to concentrated if membrane and net water movement are explicit.' },
      { q: '3', guide: 'Large surface area; thin epithelium/short diffusion distance; good blood supply maintains gradients; lacteal for lipid products. Any four linked valid points.' },
      { q: '4', guide: 'Vaccine exposes antigens; stimulates lymphocytes/antibody response and memory cells; later response faster/greater; fewer susceptible hosts reduces transmission, indirectly protecting others.' },
      { q: '5', guide: 'Bubble size varies / bubbles may merge / oxygen can dissolve. Improvements: measure gas volume with gas syringe/capillary or dissolved oxygen; control temperature; allow equilibration. Two paired limitation+improvement points.' },
      { q: '6', guide: 'Raised CO2 lowers blood pH; detected by receptors/brain; respiratory centre increases ventilation to remove CO2 / restore conditions.' },
      { q: '7', guide: 'Rise detected by pancreas; beta cells release insulin; cells take up glucose; liver/muscle convert glucose to glycogen; concentration falls toward normal, reducing insulin stimulus.' },
      { q: '8', guide: 'Aa × Aa gives AA, Aa, Aa, aa; probability affected child = 1/4 or 25%.' },
      { q: '9', guide: 'Variation arises by mutation; antibiotic kills susceptible bacteria; resistant individuals survive and reproduce; resistance allele passed on; frequency rises over generations.' },
      { q: '10', guide: 'Sum 40; mean 4 per 0.25 m²; density 16 m⁻²; estimate 1600 daisies in 100 m². Credit sensible method.' },
      { q: '11', guide: 'pH independent variable; time for starch disappearance or rate dependent variable; controls such as temperature, enzyme concentration, starch concentration/volume, total volume; iodine sampling/end-point; repeats and mean / finer pH intervals / water bath. Up to 8.' },
      { q: '12', guide: 'Sample too small; duration short; only one concentration; no control mentioned; conclusion overgeneralises; need replication/range/control/longer time and statistical/variability consideration.' }
    ]
  },
  'alevel-diagnostic-marking-guide': {
    title: 'A-Level Diagnostic Indicative Marking Guide (Part C)',
    items: [
      { q: '1', guide: 'Specific 3D tertiary structure creates active site; complementary chemical/shape interactions; pH changes H+ concentration, disrupting ionic/H-bonds; tertiary structure/active site changes; fewer enzyme-substrate complexes.' },
      { q: '2', guide: 'Phospholipid bilayer; hydrophobic core restricts ions/polar molecules; channel/carrier proteins enable facilitated/active transport; cholesterol influences fluidity/permeability; proteins/receptors embedded in dynamic membrane.' },
      { q: '3', guide: '84/420 = 0.20 (20%); visible snapshot and stage duration/sampling factors; cells may not be asynchronous / classification uncertainty.' },
      { q: '4', guide: 'Cooperative binding / sigmoid relation; high pO2 in lungs promotes loading; lower pO2 in tissues promotes unloading; high CO2/low pH shifts affinity lower (Bohr effect) in respiring tissues; supports delivery.' },
      { q: '5', guide: 'Genetic code is degenerate; altered codon may code for same amino acid; substitution may occur in non-coding/intron region if relevant to stated gene context.' },
      { q: '6', guide: 'Both use electron transfer, proton gradients and ATP synthase/chemiosmosis. Photophosphorylation: thylakoid, light-excited electrons, water donor in non-cyclic, NADP final acceptor; oxidative: inner mitochondrial membrane, reduced NAD/FAD donors, oxygen final acceptor, water product.' },
      { q: '7', guide: 'Na+/K+ pump and selective K+ permeability create negative interior; voltage-gated Na+ channels open at threshold causing depolarisation; Na+ channels close/inactivate, K+ channels open causing repolarisation/hyperpolarisation; gradients restored.' },
      { q: '8', guide: 'q=.20, p=.80; p²=.64, 2pq=.32, q²=.04.' },
      { q: '9', guide: 'DNA methylation commonly reduces transcription by affecting transcription-factor access/chromatin; histone acetylation generally opens chromatin/increases transcription; deacetylation/other modifications can compact chromatin. Credit two explained mechanisms.' },
      { q: '10', guide: 'Null: treatment produces no statistically significant difference in mean growth rate vs control. Need data type/distribution, independence/paired design, number of groups, assumptions, and intended comparison/association to choose test.' },
      { q: '11', guide: 'Correlation does not establish direction or mechanism; confounders may affect both; observational association could arise from other variables; causal claim requires stronger design/evidence.' },
      { q: '12', guide: 'Up to 9 for four or more accurate, developed membrane roles with explicit connections: cell-surface transport/signalling, organelle compartmentalisation, chemiosmosis in mitochondria/chloroplasts, synaptic/neuronal membranes, immune recognition, vesicles/secretion, etc. Reward linked biological reasoning over list.' },
      { q: '13', guide: 'Prepare sucrose solutions of known water potential/concentration; equal potato pieces; control time/temp/size; measure initial/final mass or length; calculate percentage change; plot change against solution water potential/concentration; zero-change point estimates tissue water potential.' }
    ]
  },
  'specification-boundary-key': {
    title: 'Specification-Boundary Key (Part D)',
    note: 'Boundary classification is deliberately pedagogical rather than a substitute for the live specification. Where a statement spans multiple tiers/routes, discuss the candidate’s reasoning and verify against the current specification before making deployment decisions.',
    key: {
      1: 'C', 2: 'B', 3: 'A', 4: 'A', 5: 'C',
      6: 'H', 7: 'C', 8: 'A', 9: 'A', 10: 'C',
      11: 'A', 12: 'O', 13: 'C', 14: 'B', 15: 'C',
      16: 'A', 17: 'C', 18: 'B', 19: 'A', 20: 'O',
      21: 'C', 22: 'A', 23: 'A', 24: 'C', 25: 'A',
      26: 'C', 27: 'A', 28: 'C', 29: 'O', 30: 'C'
    }
  },
  'examiner-calibration-key': {
    title: 'Examiner Calibration Key (Part E)',
    items: [
      { id: 'E1', mark: '1/3', guide: 'Credit only idea that high vaccination reduces transmission / fewer susceptible hosts if implied. "Vaccines kill disease" is inaccurate; "nobody can catch it" overclaims. No clear immune-memory mechanism.' },
      { id: 'E2', mark: '2/3', guide: 'Credit more kinetic energy and more frequent collisions; "enzyme gets more energy" is imprecise. Full credit would require more successful enzyme-substrate collisions / complexes.' },
      { id: 'E3', mark: '3/3', guide: 'No photosynthesis in dark; respiration continues; stored organic matter consumed and products such as CO2/water may leave. Strong causal chain.' },
      { id: 'E4', mark: '2/2', guide: 'Prevents conscious placement bias and makes sample more representative/fair. Accept wording.' },
      { id: 'E5', mark: '1/3', guide: 'Recognises reduced usable intake/energy but confuses digestion with absorption. Needs reduced surface area/absorption of digested nutrients into blood.' },
      { id: 'E6', mark: '2/2', guide: 'Influenza is viral; antibiotics act against bacteria, not viruses.' }
    ]
  },
  'teaching-audition-rubric': {
    title: 'Teaching Audition Rubric (Part I5)',
    criteria: [
      'Scientific accuracy', 'Clarity & sequencing', 'Diagnostic questioning', 'Learner participation',
      'Misconception handling', 'Adaptation to learner', 'Exam relevance', 'Checking for understanding',
      'Feedback quality', 'Pace & professional presence'
    ],
    levels: [
      { score: 1, label: 'Weak', desc: 'Inaccurate/absent' },
      { score: 2, label: 'Developing', desc: 'Inconsistent; major gaps' },
      { score: 3, label: 'Secure', desc: 'Accurate/basic and functional' },
      { score: 4, label: 'Strong', desc: 'Precise, responsive and purposeful' },
      { score: 5, label: 'Inspire-level', desc: 'Exceptional precision, diagnosis and learner thinking' }
    ],
    passExpectation: 'Overall mean ≥4.0/5 with Scientific Accuracy ≥4/5. Entry audition itself is diagnostic and may be below pass standard.'
  },
  'week1-assignment-scoring': {
    title: 'Week 1 Assignment Scoring (Part I6)',
    rows: [
      { evidence: 'UK Biology system map', weight: '10%', passIndicator: 'Accurate and complete' },
      { evidence: 'Specification maps', weight: '25%', passIndicator: '≥90% boundary/statement accuracy' },
      { evidence: 'AO classification', weight: '15%', passIndicator: '≥85% correct' },
      { evidence: 'Three-level enzyme lesson', weight: '20%', passIndicator: 'Clear adaptation; no inappropriate content drift' },
      { evidence: 'Microteaching', weight: '20%', passIndicator: 'Mean ≥4/5; accuracy ≥4' },
      { evidence: 'Reflective brief', weight: '10%', passIndicator: 'Specific, evidence-based, actionable' }
    ],
    gate: 'Week 1 overall gate: ≥80% AND all evidence submitted AND no critical scientific/professional concern. A failed component is retrained and reassessed; the candidate does not simply accumulate compensating marks.'
  }
};

// Registry, keyed by stageId. Stages 2-4's confidential content
// (Pack 03's confidential examiner-school section, Pack 02/04's
// assessor rubrics) is added here as those stages are built.
const CONFIDENTIAL_CONTENT = {
  'biology-gcse-stage-1': STAGE_1
};

function getConfidentialContent(stageId, key) {
  const stage = CONFIDENTIAL_CONTENT[stageId];
  if (!stage) return null;
  if (!key) return stage; // return everything for this stage
  return stage[key] || null;
}

module.exports = { getConfidentialContent };
