// ISM Physics School V1: Energy & Physics Calculations Mastery Intervention.
//
// The single machine-readable definition of the school programme: scope,
// blocks, sessions, concepts, the asset behind every layer, and the authored
// delivery notes that the teacher guides are built from. The School-Ready
// Gate (readiness.js), the teacher guides (build-guides.js) and the
// programme checks all read this file; nothing restates it by hand.
//
// Concepts, misconceptions and prerequisites are NOT defined here: they come
// from the approved curriculum source (curriculum/physics/energy.js). This
// file only groups them into blocks and says how they are taught and checked.
//
// Scope frozen 29 Sep 2026 (docs/school/physics-v1/README.md §2). Changing a
// block's concepts is a scope change: say so in the commit message.
//
// Asset status vocabulary, per layer:
//   'missing'      nothing exists
//   'candidate'    something exists but has not passed subject QA for this use
//   'qa-failed'    reviewed and not fit; see the QA report
//   'reviewed'     passed subject QA; not yet approved by Eric
//   'approved'     approved by Eric (for items: in the database via the block gate)

const PROGRAMME = {
  id: 'ism-physics-energy-v1',
  title: 'Energy & Physics Calculations Mastery Intervention',
  product: 'ISM Physics School V1',
  version: '1.0.0-draft',
  scopeFrozen: '2026-09-29',
  subject: 'Physics',

  spec: {
    principal: { board: 'AQA', codes: ['8463 (Physics)', '8464 (Combined Science: Trilogy)'], sections: ['4.1 Energy', '4.5.2 Work done and energy transfer'] },
    excluded: ['4.1.2.1 Required practical 2 (thermal insulation): Physics 8463 only, not Combined; out of V1 so one product serves both'],
    mathsSkills: ['MS 1a', 'MS 1b', 'MS 3b', 'MS 3c', 'MS 3d', 'MS 4a', 'MS 4c', 'MS 4d'],
    requiredPracticals: ['RP1 specific heat capacity (4.1.1.3)'],
    otherBoards: [
      { board: 'Edexcel', codes: ['1PH0', '1SC0'], status: 'not mapped', note: 'Concepts are board-neutral; add Topic 8 (and check Topic 3) statements to the concept cards. The QA of the Energy board found its existing Edexcel mapping unverified.' }
    ],
    claim: 'Covers AQA GCSE Physics/Combined Science section 4.1 Energy (excluding RP2) and work done, with the quantitative skills they need. It is not a complete GCSE Physics course.'
  },

  delivery: {
    weeks: 6,
    sessionsPerWeek: 2,
    sessionMinutes: 60,
    groupSize: { ideal: 5, max: 6 },
    independentMinutesPerWeek: [20, 30],
    tiers: 'Both; Higher-only items are filtered out for Foundation groups',
    mode: 'Live small-group sessions (in person or online) + independent practice on the platform'
  },

  // One calculation routine for the whole programme. The Week 1 QA found three
  // different routines across two lessons; pupils must meet one.
  // PROPOSED: keeps Week 1's names (GIVEN, FIND, RELATIONSHIP, SUBSTITUTE,
  // SOLVE, CHECK) and adds the REARRANGE step it lacked. Needs Eric's approval.
  calculationRoutine: {
    status: 'proposed',
    steps: [
      { name: 'GIVEN', say: 'List every quantity with its symbol and unit. Convert to SI units now (kg, m, s, J, W).' },
      { name: 'FIND', say: 'Write the symbol of the quantity you need.' },
      { name: 'RELATIONSHIP', say: 'Write the equation in symbols (from memory, or from the equation sheet if it is a given equation).' },
      { name: 'REARRANGE', say: 'Make the unknown the subject before putting numbers in.' },
      { name: 'SUBSTITUTE', say: 'Put the numbers in. This line usually earns the first mark.' },
      { name: 'SOLVE', say: 'Calculate. Give the unit, and the significant figures asked for.' },
      { name: 'CHECK', say: 'Is the size sensible? Is the unit right for the quantity?' }
    ]
  },

  // The three kinds of programme check, all served by the diagnostic runtime in
  // "programme check" mode. Items are the approved items tagged to the
  // concepts, filtered by evidence class. None of them produces a grade.
  checks: {
    baseline: {
      id: 'ism-physics-energy-v1:baseline', minutes: 35,
      evidenceClasses: ['diagnostic'], perConcept: { min: 1, target: 2 },
      purpose: 'Initial mastery hypothesis for every concept, before teaching. The teacher validates it.'
    },
    block: {
      evidenceClasses: ['mastery_check'], perConcept: { min: 2, target: 3 }, minutes: 15,
      purpose: 'End-of-block mastery check. Independent of teaching examples and practice items.',
      secondAttempt: 'A second mastery check must use items the pupil has not seen (reviewer criterion D1). A concept needs at least 3 approved mastery-check items for two attempts at 2 items minimum, including one numeric.'
    },
    reassessment: {
      id: 'ism-physics-energy-v1:reassessment', minutes: 35,
      evidenceClasses: ['retrieval', 'diagnostic'], perConcept: { min: 1, target: 2 },
      parallelTo: 'baseline',
      purpose: 'Like-for-like comparison with the baseline: the same concepts, bands and contexts on parallel items (template instances for calculation concepts; a parallel fixed item for conceptual ones). Never the identical items: pupils have seen those answers in the review screen.'
    }
  },

  // Standard session shapes (60 minutes). The Inspire lesson DNA, compressed
  // for school intervention slots.
  sessionShapes: {
    teach: [
      { min: 5, part: 'Retrieval', what: '3 questions on earlier blocks (interleaved); pupils answer on mini-whiteboards or in the lesson' },
      { min: 15, part: 'Concept construction', what: 'Build the idea from a situation; name the stores/quantities precisely' },
      { min: 10, part: 'Worked examples', what: 'Two examples: one fully worked, one faded (pupils finish it)' },
      { min: 10, part: 'Guided practice', what: 'Pupils work; the teacher circulates and uses the hinge question' },
      { min: 15, part: 'Independent practice', what: 'Graded practice ending in a stretch question' },
      { min: 5, part: 'Exit ticket', what: '2–3 questions, answered without notes; the teacher marks them before the next session' }
    ],
    consolidate: [
      { min: 5, part: 'Retrieval', what: 'Exit-ticket errors from last session, plus 2 interleaved questions' },
      { min: 10, part: 'Misconception clinic', what: 'The block misconception most seen in exit tickets: contrasting cases' },
      { min: 10, part: 'Guided practice', what: 'Harder, less familiar contexts' },
      { min: 15, part: 'Independent + Grade 9 challenge', what: 'Multi-step, unfamiliar context' },
      { min: 15, part: 'Block mastery check', what: 'On the platform, independently, no notes (programme check)' },
      { min: 5, part: 'Error log', what: 'Each pupil logs one error: what I did, why, the correct physics, my next step' }
    ]
  },

  blocks: [
    {
      id: 'B1', week: 1, title: "The Physicist's Toolkit",
      concepts: ['phy.skills.units-prefixes', 'phy.skills.standard-form', 'phy.skills.rearranging', 'phy.skills.graph-reading'],
      sessions: ['teach', 'consolidate'],
      intent: 'Repair the quantitative skills every Energy calculation depends on, so later errors can be diagnosed as physics errors rather than maths errors.',
      lesson: {
        status: 'qa-failed', qa: 'docs/school/physics-v1/qa/week1-toolkit.md',
        candidates: ['ISM Class: Week 1 - The Physicist\'s Toolkit (live; source not in git)', 'Week 1 Closing Lesson: From Situation to Solution (not in git)'],
        need: 'A Toolkit repair lesson aimed at the four concepts, with real graph work (read a value; find a gradient), M/G/T prefixes, g→kg and min→s, rearranging with a square and a half, and the one calculation routine.'
      },
      hingeQuestions: [
        { q: 'Convert 2.4 MJ into joules.', a: '2.4 × 10⁶ J (2 400 000 J)', watch: ['MIS-PHY-SKL-001', 'MIS-PHY-SKL-003'] },
        { q: 'Rearrange Ek = ½mv² to make v the subject.', a: 'v = √(2Ek ÷ m)', watch: ['MIS-PHY-SKL-005'] },
        { q: 'A straight line on a distance–time graph goes from (0 s, 0 m) to (8 s, 40 m). What is the speed?', a: '5 m/s: the gradient, 40 m ÷ 8 s', watch: ['MIS-PHY-SKL-006'] }
      ],
      stretch: 'A 60 kg cyclist has 3.0 kJ in her kinetic energy store. Calculate her speed. (Units, rearranging with a square root and a half, in one question.) Answer: v = √(2 × 3000 ÷ 60) = 10 m/s.',
      teacherNotes: [
        'Diagnose before re-teaching: pupils who are secure on a skill in the baseline skip that part of the session and go to the stretch.',
        'Insist on the calculation routine on every question this week; it is the scaffold for Blocks 2–5.',
        'Graph reading: always ask what one small square is worth before any value is read.'
      ]
    },
    {
      id: 'B2', week: 2, title: 'Stores, systems, conservation and work done',
      concepts: ['phy.energy.stores-systems', 'phy.energy.conservation', 'phy.forces.work-done'],
      sessions: ['teach', 'consolidate'],
      intent: 'A precise language for energy (stores and pathways, never "forms"), conservation in a closed system, and work done as energy transferred by a force.',
      lesson: {
        status: 'qa-failed', qa: 'docs/school/physics-v1/qa/energy-board.md',
        candidates: ['teaching-lessons/physics/inspire_physics_energy_stores_transfers_y10_final_sharp_premium.html (text usable; 5 of 7 diagrams and the Sankey are wrong)'],
        need: 'A lesson built from the premium board text with rebuilt diagrams (four pathways; a real transfer chain; to-scale Sankeys), the AQA situations (projected upwards, hitting an obstacle, accelerated by a force, kettle), and W = Fs with the distance along the line of action of the force.'
      },
      hingeQuestions: [
        { q: 'A ball is thrown straight up. As it rises, which energy store increases and which decreases?', a: 'The gravitational potential energy store (of the ball–Earth system) increases; the kinetic energy store of the ball decreases.', watch: ['MIS-PHY-ENE-002'] },
        { q: 'A car brakes to a stop. Where is the energy that was in its kinetic energy store now?', a: 'Almost all in the thermal energy stores of the brakes, tyres and surroundings (dissipated); a very small amount was transferred by sound. The total is unchanged.', watch: ['MIS-PHY-ENE-001', 'MIS-PHY-ENE-003'] },
        { q: 'A box is pushed 3 m across a floor by a horizontal force of 20 N. How much work is done by the force?', a: 'W = Fs = 20 × 3 = 60 J, so 60 J of energy is transferred by the force.', watch: ['MIS-PHY-FOR-001'] }
      ],
      stretch: 'A crate is lifted 1.5 m vertically by a force of 400 N, then carried 10 m horizontally at the same height. How much work does the lifting force do? Answer: 600 J (400 × 1.5); no work is done by the vertical force during the horizontal carry, because there is no movement along its line of action.',
      teacherNotes: [
        'Ban "heat energy", "movement energy" and "electrical energy" from the first minute; model "energy is transferred from the … store to the … store by …".',
        '"Lost" is never a final answer: ask "lost to where?" until pupils say "dissipated to the thermal energy store of the surroundings".',
        'Do not use the existing Energy board diagrams until they are rebuilt (QA report).'
      ]
    },
    {
      id: 'B3', week: 3, title: 'Kinetic and gravitational potential energy, and linking stores',
      concepts: ['phy.energy.kinetic', 'phy.energy.gravitational', 'phy.energy.transfer-calcs'],
      sessions: ['teach', 'consolidate'],
      intent: 'Recall and use Ek = ½mv² and Ep = mgh fluently, then link them: energy lost from one store equals energy gained by another in a closed system, less what is dissipated.',
      lesson: { status: 'missing', candidates: [], need: 'A full lesson: Ek and Ep calculations including rearranging for v, m and h; Ep lost = Ek gained; dissipation making the final speed smaller.' },
      hingeQuestions: [
        { q: 'Car A has the same mass as car B but is moving twice as fast. How does its kinetic energy compare?', a: 'Four times as much: kinetic energy depends on speed squared.', watch: ['MIS-PHY-ENE-004'] },
        { q: 'A 2.0 kg ball is dropped from rest from a height of 5.0 m. Ignore air resistance; g = 9.8 N/kg. How fast is it moving just before it hits the ground?', a: 'Ep lost = 2.0 × 9.8 × 5.0 = 98 J = Ek gained, so v = √(2 × 98 ÷ 2.0) = 9.9 m/s.', watch: ['MIS-PHY-ENE-004', 'MIS-PHY-ENE-014', 'MIS-PHY-SKL-005'] },
        { q: 'A skier goes 200 m down a slope and ends 30 m lower. Which value is h in Ep = mgh?', a: '30 m: the change in vertical height, not the distance along the slope.', watch: ['MIS-PHY-ENE-006'] }
      ],
      stretch: 'A 0.20 kg ball is thrown upwards at 12 m/s. Ignoring air resistance, how high does it rise? Answer: ½ × 0.20 × 12² = 14.4 J; h = 14.4 ÷ (0.20 × 9.8) = 7.3 m. (Mass cancels: h = v² ÷ 2g.)',
      teacherNotes: [
        'Use AQA g = 9.8 N/kg unless a question gives another value.',
        'The approved kinetic and gravitational packs are live; use their practice items after the lesson, and keep their mastery-check items unseen until the block check.'
      ]
    },
    {
      id: 'B4', week: 4, title: 'Elastic potential energy and specific heat capacity',
      concepts: ['phy.energy.elastic', 'phy.energy.shc'],
      sessions: ['teach', 'consolidate'],
      intent: 'Select and use the given equations Ee = ½ke² and ΔE = mcΔθ, keeping force and energy apart for springs and temperature and thermal energy apart for heating; describe and analyse Required practical 1.',
      lesson: { status: 'missing', candidates: [], need: 'A lesson on Ee = ½ke² (extension in metres; within the limit of proportionality) and ΔE = mcΔθ with RP1: method, variables, sources of error, and finding c from data.' },
      hingeQuestions: [
        { q: 'A spring with spring constant 50 N/m is stretched by 4.0 cm. How much energy is stored in it?', a: 'e = 0.040 m; Ee = ½ × 50 × 0.040² = 0.040 J.', watch: ['MIS-PHY-ENE-008', 'MIS-PHY-ENE-015', 'MIS-PHY-ENE-005'] },
        { q: '0.50 kg of water (c = 4200 J/kg °C) is heated from 20 °C to 60 °C. How much energy is transferred to its thermal energy store?', a: 'ΔE = 0.50 × 4200 × 40 = 84 000 J.', watch: ['MIS-PHY-SKL-002'] },
        { q: 'The same energy is supplied to 1 kg of water and 1 kg of copper. Which has the larger temperature rise, and why?', a: 'The copper: it has a lower specific heat capacity, so less energy is needed to raise the temperature of 1 kg by 1 °C.', watch: ['MIS-PHY-ENE-010', 'MIS-PHY-ENE-009'] }
      ],
      stretch: 'In RP1, a 1.0 kg aluminium block is heated by a 50 W heater for 10 minutes and its temperature rises by 30 °C. Calculate a value for the specific heat capacity of aluminium, and explain why it is higher than the true value. Answer: E = 50 × 600 = 30 000 J; c = 30 000 ÷ (1.0 × 30) = 1000 J/kg °C. It is too high because some energy is dissipated to the surroundings, so not all 30 000 J went into the block.',
      teacherNotes: [
        'Both equations are given on the equation sheet: pupils select them, they do not need to recall them.',
        'Separate "how hot" (temperature, °C) from "how much energy" (thermal energy, J) every time.'
      ]
    },
    {
      id: 'B5', week: 5, title: 'Power, efficiency and energy resources',
      concepts: ['phy.energy.power', 'phy.energy.dissipation-efficiency', 'phy.energy.resources'],
      sessions: ['teach', 'consolidate'],
      intent: 'Power as the rate of energy transfer; efficiency (energy and power forms) and ways of reducing unwanted transfers; evaluate energy resources.',
      lesson: { status: 'missing', candidates: [], need: 'A lesson on P = E/t and P = W/t, efficiency as a decimal and a percentage (energy and power forms), lubrication, insulation and thermal conductivity, and resources (renewable vs non-renewable, reliability, environmental impact). Resources can be taught as guided independent study.' },
      hingeQuestions: [
        { q: 'Motor A lifts a load through 2 m in 4 s. Motor B lifts the same load through 2 m in 8 s. Which motor has the greater power, and why?', a: 'Motor A: both do the same work (transfer the same energy), and A does it in less time.', watch: ['MIS-PHY-ENE-011'] },
        { q: 'A motor is supplied with 500 J and transfers 350 J usefully. What is its efficiency?', a: '350 ÷ 500 = 0.70 (70%). No unit, and never more than 1.', watch: ['MIS-PHY-ENE-012'] },
        { q: 'Why is wind a less reliable resource than gas for generating electricity?', a: 'Wind turbines only generate when the wind is blowing, and output varies with wind speed; gas can be burned whenever electricity is needed.', watch: ['MIS-PHY-ENE-013'] }
      ],
      stretch: 'A 1.2 kW kettle takes 3.0 minutes to heat water. The water gains 180 kJ. Calculate the efficiency of the kettle. Answer: E supplied = 1200 × 180 = 216 000 J; efficiency = 180 000 ÷ 216 000 = 0.83 (83%).',
      teacherNotes: [
        'Power is a rate: always ask "in how long?" when a pupil compares devices by energy alone.',
        'Resources: assess evaluation (reliability, environmental impact, cost) as well as classification. Nuclear is non-renewable.'
      ]
    },
    {
      id: 'W6', week: 6, title: 'Exam application, remediation and reassessment',
      concepts: [],
      sessions: ['application', 'reassess'],
      intent: 'Transfer to unfamiliar exam-style contexts, close the gaps the block checks found, and reassess every concept on parallel items.',
      lesson: { status: 'missing', candidates: [], need: 'A command-word and lost-marks session on Inspire-written multi-concept application items (3–6 marks, with mark schemes). Then a remediation carousel driven by each pupil\'s pathway, and the 35-minute reassessment.' },
      hingeQuestions: [],
      teacherNotes: [
        'Remediation groups come from the teacher programme view: pupils with the same recommended action work together.',
        'Past-paper questions may be referenced by paper and question number from the school\'s own copies; Inspire does not distribute them.'
      ]
    }
  ],

  // What happens after a block mastery check (Layer F). The routing is
  // computed by assets/js/mastery-rules.js; this is the teacher-facing rule.
  remediationPolicy: {
    passThreshold: 'A concept passes the block check when every mastery-check item on it is right and no sure-wrong answer signals one of its misconceptions.',
    afterFirstFail: 'The pupil gets the recommended remediation (misconception clinic, prerequisite repair or worked-example re-teach), then a second mastery check on items they have not seen.',
    afterSecondFail: 'Escalate to the teacher (E1): 5-minute 1:1 on the evidence; the teacher chooses a live re-teach, a prerequisite mini-lesson, or an override with a reason.',
    neverDo: 'Never "You scored 45%. Next topic." Never label a pupil from one answer. Never show an untaught concept as insecure.'
  },

  // Decisions only Eric can make; listed in the gate until resolved.
  decisionsPending: [
    'Approve (or replace) the single calculation routine above.',
    'Which Week 1 file is the canonical live version (the live ism_lesson_versions row), so it can come into git and be corrected.',
    'Whether the corrections in qa/week1-toolkit.md are applied to the live ISM lesson now.',
    'Whether the Energy teaching board is reachable by pupils today through the lessons table (it must not be until rebuilt).',
    'Who authors the Block 2–5 lessons: Eric, an Inspire educator, or the drafting agent with the reviewer (the pipeline supports all three).',
    'Data protection for school pupils: a school is the data controller; a data processing agreement and a school-facing privacy notice are needed before any school pilot.'
  ]
};

module.exports = { PROGRAMME };
