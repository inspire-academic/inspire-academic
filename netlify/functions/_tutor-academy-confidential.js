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

// Source: IBTAEP Pack 03, "CONFIDENTIAL ASSESSOR SECTION" (sections
// 15-20, following the candidate-facing Week 3 self-evaluation and
// preceding the general closing "Source & Use Notes"). Pack 03's own
// header on this block: "Remove or withhold this section if the
// candidate is completing the formal Week 3 assessment under
// controlled conditions."
const STAGE_3 = {
  'ao-classification-key': {
    title: 'AO Classification Drill — Suggested Classifications (Section 15)',
    note: 'Accept a well-reasoned alternative where the complete task plausibly changes the AO emphasis. Command words can be useful clues, but they are not a perfect one-to-one code for assessment objectives.',
    items: [
      { q: 1, ao: 'AO1' }, { q: 2, ao: 'AO2' }, { q: 3, ao: 'AO2' }, { q: 4, ao: 'AO3' }, { q: 5, ao: 'AO1' },
      { q: 6, ao: 'AO2' }, { q: 7, ao: 'AO2' }, { q: 8, ao: 'AO3' }, { q: 9, ao: 'AO1' }, { q: 10, ao: 'AO2' },
      { q: 11, ao: 'AO3' }, { q: 12, ao: 'AO1' }, { q: 13, ao: 'AO3' }, { q: 14, ao: 'AO2' }, { q: 15, ao: 'AO3' },
      { q: 16, ao: 'AO1/AO2' }, { q: 17, ao: 'AO3' }, { q: 18, ao: 'AO1' }, { q: 19, ao: 'AO2' }, { q: 20, ao: 'AO2' }
    ],
    commandSwitchBenchmark: 'Look for the candidate to articulate response behaviour, not merely repeat definitions: describe = accurate account/pattern; explain = reasons/mechanism; compare = both items; suggest = applied plausible Biology; evaluate = weigh evidence/limitations and judge; justify = support a choice using supplied evidence.'
  },
  'suggest-clinic-key': {
    title: 'Suggest Clinic — Indicative Content (Section 16)',
    items: [
      { q: 1, guide: 'Cold conditions reduce membrane fluidity; unsaturated fatty acids contain double bonds that create kinks and prevent tight packing; this helps membranes remain sufficiently fluid/functioning. Award up to 3 for coherent application.' },
      { q: 2, guide: 'Roadside pollution such as sulfur dioxide/nitrogen pollutants may reduce lichen abundance; accept defensible pollution mechanism at GCSE level.' },
      { q: 3, guide: 'Stopping early may leave more resistant bacteria alive; survivors reproduce; resistance alleles/traits become more common; future antibiotic treatment becomes less effective.' },
      { q: 4, guide: 'Variation/mutation produces darker individuals; if dark colour gives camouflage/fitness advantage, darker insects survive/reproduce more; alleles for dark colour are inherited; frequency rises over generations.' },
      { q: 5, guide: 'Possible enzyme inhibition/product inhibition/another limiting factor or measurement artefact if biologically defensible and linked to observed fall. Do not accept denaturation merely because substrate concentration is high without further justification.' }
    ],
    dataSchoolIndicative: {
      title: 'Data School Indicative Marking',
      items: [
        'Enzyme Q1: rate rises from 10 to 40°C, peaks at 40°C in sampled values, then falls sharply to 60°C.',
        'Q2: increased kinetic energy → more frequent successful collisions/enzyme-substrate complexes up to optimum.',
        'Q3: high temperature disrupts enzyme structure/active site → fewer successful complexes.',
        'Q4: data support 40°C as best of temperatures tested, but true optimum could lie between tested values; repeats/range matter.',
        'Field Q5: Site B, smallest range.',
        'Q6: similar means can conceal very different spread/variability and sampling consistency.'
      ]
    }
  },
  'calibration-sets-key': {
    title: 'Marking Calibration Sets — Assessor Key (Section 17)',
    setA: {
      title: 'Set A — vigorous exercise [4]',
      indicativePoints: 'Muscles require more energy / rate of respiration rises; more oxygen needed for aerobic respiration; more carbon dioxide produced; ventilation increases to supply oxygen/remove carbon dioxide. Equivalent scientifically accurate chains accepted.',
      students: [
        { id: 'A', mark: 4, rationale: 'Coherent full chain.' },
        { id: 'B', mark: 1, rationale: 'Vague but recognises increased body demand; "needs air" lacks precision.' },
        { id: 'C', mark: '0-1', rationale: 'Contains serious misconception that glucose is made in lungs; only credit any separable valid idea.' },
        { id: 'D', mark: 4, rationale: 'Short but connected enough if causality is clear.' }
      ]
    },
    setB: {
      title: 'Set B — plant in darkness [3]',
      students: [
        { id: 'E', mark: 3, rationale: 'No photosynthesis + continued respiration + stored organic matter used/mass leaves system.' },
        { id: 'F', mark: 0, rationale: 'Unsupported/overgeneralised.' },
        { id: 'G', mark: 2, rationale: 'Core mechanism present; lacks a developed mass-loss consequence.' },
        { id: 'H', mark: 0, rationale: 'Darkness does not itself justify increased evaporation.' }
      ]
    }
  },
  'formal-assessment-mark-scheme': {
    title: 'Week 3 Formal Assessment — Mark Scheme (Section 18)',
    sectionA: {
      title: 'Section A — Command and AO literacy [15]',
      items: [
        { q: 1, marks: 2, content: 'Both items must be addressed; similarities and/or differences relevant to question.' },
        { q: 2, marks: 2, content: 'Describe = accurate account; explain = reasons/mechanism.' },
        { q: 3, marks: 2, content: 'Apply knowledge/understanding to a new or unfamiliar situation.' },
        { q: 4, marks: 2, content: 'AO3; judging conclusion against evidence.' },
        { q: 5, marks: 2, content: 'AO1; direct recall.' },
        { q: 6, marks: 2, content: 'Primarily AO2; applies graph/data and knowledge to decision.' },
        { q: 7, marks: 3, content: 'AO depends on full task/context; same command can appear in different cognitive settings; command is a clue, not complete classification.' }
      ]
    },
    sectionB: {
      title: 'Section B — Question anatomy [15]',
      items: [
        { q: 8, marks: 5, content: 'Hormone receptor blockade should be linked to failure/reduction of target-cell response. Accept insulin/glucagon reasoning if coherent with stated receptor context. Reward question deconstruction plus accurate model answer.' },
        { q: 9, marks: 5, content: 'Correlation/design limitations: groups may differ initially; confounders; replication/sample size; measurement; control; random allocation; evidence supports association only if design justifies causality. Require judgement.' },
        { q: 10, marks: 5, content: 'Habitat fragmentation/loss, disturbance, pollution, mortality, reduced food/nesting, isolated populations, altered abiotic conditions; reward plausible linked explanations.' }
      ]
    },
    sectionC: {
      title: 'Section C — Marking calibration [15]',
      items: [
        { q: '11', marks: 6, content: 'A ≈3/4 depending wording; B ≈1/4; C ≈4/4. Award 3 marks for sensible scoring and 3 for defensible justifications.' },
        { q: '12', marks: 3, content: 'B is primarily L/E or K depending explanation; intervention should increase biological precision and causal mechanism.' },
        { q: '13', marks: 6, content: 'Full model should mention reduced absorption/increased water loss and net fall in body water.' }
      ]
    },
    sectionD: {
      title: 'Section D — Extended response coaching [15]',
      items: [
        { q: 14, marks: 15, content: 'Look for misconceptions: need-based mutation/teleology; "getting used to" antibiotic; inaccurate inheritance language; missing pre-existing variation/mutation, selection pressure, differential survival/reproduction, inheritance and change in allele/trait frequency. Coaching plan should include diagnosis, corrected model, worked example, guided practice, independent parallel question and feedback.' }
      ]
    }
  },
  'examiner-school-observation-rubric': {
    title: 'Examiner School Observation Rubric (Section 19)',
    domains: ['Question diagnosis', 'Command teaching', 'Modelling', 'Student thinking', 'Feedback', 'Biological accuracy', 'Efficiency', 'Transfer'],
    passExpectation: 'Overall average ≥4/5; Biological Accuracy ≥4/5; Question Diagnosis ≥4/5; no domain below 3/5.'
  },
  'week3-progression-board': {
    title: 'Week 3 Progression Board (Section 20)',
    thresholds: [
      { evidence: 'Command Word Academy', threshold: '≥90%' },
      { evidence: 'AO classification', threshold: '≥85%' },
      { evidence: '100-mark laboratory', threshold: 'Complete' },
      { evidence: 'Marking calibration', threshold: '≥90% agreement' },
      { evidence: 'Formal assessment', threshold: '≥80%' },
      { evidence: 'Microteaching', threshold: '≥4/5' },
      { evidence: 'Biological accuracy', threshold: 'Critical gate ≥4/5' }
    ],
    decisionOptions: ['PASS — proceed to Pack 04: Practical Biology, Mathematics & GCSE Clearance', 'CONDITIONAL PASS — targeted remediation required before Pack 04', 'REPEAT EXAMINER SCHOOL — assessment literacy not yet deployment-ready']
  }
};

// Source: IBTAEP Pack 04, sections 28-29 — "Confidential Assessor
// Marking Guide — Practical Transfer" and "Confidential Assessor Guide
// — Clearance Examination". Both explicitly headed CONFIDENTIAL in the
// source pack, unlike section 30 (the assessor's own observation/
// decision record template) and section 31 (the post-clearance
// deployment charter), which are candidate-visible content in
// tutor-academy-biology-content.js.
const STAGE_4 = {
  'practical-transfer-marking-guide': {
    title: 'Confidential Assessor Marking Guide — Practical Transfer (Section 28)',
    note: 'Indicative marking points; accept scientifically equivalent wording. Do not reward vague statements when mechanism is required.',
    items: [
      { q: 'Q1', points: 'Salt concentration; water uptake/change in mass/length as DV; two relevant controls such as time, temperature, seedling size/species.' },
      { q: 'Q2', points: 'Normalises change to starting value; permits fair comparison across different initial masses.' },
      { q: 'Q3', points: 'Recognise 14 as likely anomaly; check method/data; justify exclusion only if evidence supports; use mean/median appropriately.' },
      { q: 'Q4', points: 'Area reflects two-dimensional zone size; πr²; diameter must be converted to radius.' },
      { q: 'Q5', points: 'Distance is proxy not direct intensity; ambient light/geometry; use light meter or standardise setup.' },
      { q: 'Q6', points: 'Correlation supports association; confounders possible; sampling quality; manipulative/controlled follow-up needed for stronger causal inference.' },
      { q: 'Q7', points: 'Clear IV/DV, controls, range, repeats/mean, measurement endpoint, temperature control, safety and appropriate data treatment.' }
    ]
  },
  'clearance-exam-marking-guide': {
    title: 'Confidential Assessor Guide — Clearance Examination (Section 29)',
    note: 'Use professional judgement alongside these anchors. Award marks for equivalent scientifically accurate responses.',
    items: [
      { q: 1, idea: 'Thin specimen transmits light; coverslip flattens/protects/keeps specimen stable; improves focus/observation.' },
      { q: 2, idea: 'Change relative to start enables comparison.' },
      { q: 3, idea: 'Relevant culture/agar/disc size/concentration/time/temp controls; aseptic/safe method.' },
      { q: 4, idea: 'Repeats improve reliability/estimate random variation; validity depends on design/control of confounders.' },
      { q: 5, idea: 'Systematic positions along transect + quadrat counts; repeat/mean; environmental factor measured.' },
      { q: 6, idea: 'Temperature affects enzyme activity; confounded; use water bath/monitor temp.' },
      { q: 7, idea: 'Practice/learning effect.' },
      { q: 8, idea: 'Confirms reagent/procedure works; distinguishes true negative from failed test.' },
      { q: 9, idea: '600×.' },
      { q: 10, idea: '10% increase.' },
      { q: 11, idea: 'Mean 16; 42 likely anomaly/outlier; discuss rather than silently average.' },
      { q: 12, idea: '1600 plants.' },
      { q: 13, idea: '0.05 units s⁻¹.' },
      { q: 14, idea: '4.5µm; 4.5 × 10⁻⁶ m.' },
      { q: 15, idea: 'Implies precision unsupported by instrument/data.' },
      { q: 16, idea: 'Any valid inverse biological relationship with explanation.' },
      { q: 17, idea: 'Same setup/person vs changed operator/setup and similar outcome.' },
      { q: 18, idea: 'Third variables/reverse direction/chance; controlled evidence needed.' },
      { q: 19, idea: 'Name specific limitation → explain effect → targeted improvement.' },
      { q: 20, idea: 'Math/exam communication; units + interpretation routine.' },
      { q: 21, idea: 'Use one graph task split into: read axes/scale → calculate/extract → explain biological pattern → command-word check; classify breakdown.' }
    ]
  }
};

// Registry, keyed by stageId.
const CONFIDENTIAL_CONTENT = {
  'biology-gcse-stage-1': STAGE_1,
  'biology-gcse-stage-3': STAGE_3,
  'biology-gcse-stage-4': STAGE_4
};

function getConfidentialContent(stageId, key) {
  const stage = CONFIDENTIAL_CONTENT[stageId];
  if (!stage) return null;
  if (!key) return stage; // return everything for this stage
  return stage[key] || null;
}

module.exports = { getConfidentialContent };
