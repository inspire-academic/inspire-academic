// tutor-academy-biology-content.js — candidate-facing Inspire Tutor
// Academy content for the Biology GCSE pathway. Transformed (not
// copy-pasted verbatim as a document dump) from the real IBTAEP source
// packs in resources/tutor-academy/biology-gcse/ — see each pack's
// header comment below for provenance. Confidential assessor-only
// content (mark schemes, rubric keys) is NOT here — see
// netlify/functions/_tutor-academy-confidential.js.
//
// Stage 1 content sourced from: 01_IBTAEP_Pack_01_Entry_Diagnostic_and_Week_1.docx
// Stages 2-4 are not yet built — see coming_soon flag below.

const TUTOR_ACADEMY_BIOLOGY = {
  'biology-gcse-stage-1': {
    title: 'Entry Diagnostic & Week 1',
    subtitle: 'Entering the UK Biology System',
    overview: 'This stage establishes your baseline as an experienced Biology teacher adapting to UK GCSE and A-level tutoring. It is not a test of whether you know Biology — it is a diagnostic that reveals exactly where your existing expertise needs translating into UK specification, exam-board and mark-scheme fluency.',
    whyThisMatters: 'The Inspire Standard is simple: a learner should leave your lesson understanding Biology more deeply, thinking more scientifically, feeling more capable, and demonstrably better equipped for their exam. Getting there means converting the Biology you already know into precise UK specification and exam literacy — this stage finds out exactly where that conversion work needs to start.',
    learningOutcomes: [
      'Explain the architecture of GCSE and A-level Biology in England — tiers, routes, exam boards, specifications.',
      'Navigate the AQA specification accurately and use it to make teaching decisions.',
      'Distinguish AO1/AO2/AO3 exam demand and classify questions by cognitive level.',
      'Adapt the same concept across Foundation, Higher and Grade 8-9 stretch without sacrificing accuracy.',
      'Deliver a short Inspire-style diagnostic tutoring sequence.'
    ],
    sections: [
      {
        id: 'orientation',
        title: 'Part A — Orientation & Programme Contract',
        type: 'orientation',
        intro: 'You are entering this programme as an already-qualified, experienced Biology teacher. The purpose is not to reteach Biology from first principles — it is to convert your existing scientific and pedagogical competence into precise UK examination, tutoring and student-development competence.',
        competencies: [
          'Scientific accuracy', 'Specification accuracy', 'Exam and mark-scheme literacy',
          'Practical and mathematical Biology', 'Adaptive teaching', 'Diagnostic tutoring',
          'Student participation and questioning', 'Safeguarding and professional conduct',
          'Accurate records and communication'
        ],
        declaration: 'I understand that the Entry Diagnostic is intended to reveal my current baseline, not to judge my professional worth. I will complete diagnostic sections independently and will identify any external resources used where authorised.'
      },
      {
        id: 'gcse-diagnostic',
        title: 'Part B — Entry Diagnostic: GCSE Biology',
        type: 'diagnostic',
        instructions: 'Recommended time: 90 minutes. Total: 60 marks. Answer without external resources — specifications, textbooks, mark schemes or AI tools. Show working for calculations. Use precise biological terminology. This is a diagnostic, not a judgement of your professional worth.',
        totalMarks: 60,
        groups: [
          { heading: 'Section B1 — Cell Biology & Organisation', questions: [
            { id: 'b1a', marks: 3, text: 'A student observes a cheek cell under a light microscope. The image of the cell is 36 mm wide. The actual cell width is 60 μm. Calculate the magnification.' },
            { id: 'b1b', marks: 3, text: 'Explain why a cell with a very large surface-area-to-volume ratio can exchange substances with its environment more rapidly than a similarly shaped larger cell.' },
            { id: 'b2', marks: 3, text: 'A student says, "Osmosis is the movement of water from a dilute solution to a concentrated solution." Improve this statement so that it is scientifically precise enough for GCSE Higher Biology.' },
            { id: 'b3', marks: 4, text: 'Explain how the structure of a villus is adapted for absorption of digested food molecules.' }
          ]},
          { heading: 'Section B2 — Infection, Bioenergetics & Homeostasis', questions: [
            { id: 'b4', marks: 4, text: 'Vaccination can reduce transmission of a communicable disease through a population. Explain how.' },
            { id: 'b5', marks: 4, text: 'A student places pondweed at different distances from a lamp and counts bubbles released per minute. Identify two limitations of bubble count as a measure of photosynthetic rate and give one improvement for each limitation.' },
            { id: 'b6', marks: 4, text: 'During vigorous exercise, the concentration of carbon dioxide in the blood rises. Explain how this contributes to an increase in breathing rate.' },
            { id: 'b7', marks: 5, text: 'Explain the negative-feedback response when blood glucose concentration rises after a carbohydrate-rich meal.' }
          ]},
          { heading: 'Section B3 — Genetics, Evolution & Ecology', questions: [
            { id: 'b8', marks: 4, text: 'Two heterozygous parents have a child for a recessive genetic condition. Use genetic notation of your choice to calculate the probability that their child has the condition.' },
            { id: 'b9', marks: 5, text: 'Explain how natural selection can lead to antibiotic resistance becoming common in a bacterial population.' },
            { id: 'b10', marks: 4, text: 'A quadrat survey records the number of daisies in ten 0.25 m² quadrats: 4, 6, 5, 0, 7, 3, 5, 4, 6, 0. Calculate the mean number of daisies per quadrat and estimate the number of daisies in a 100 m² field, assuming the quadrats were randomly sampled.' }
          ]},
          { heading: 'Section B4 — Practical & Data Reasoning', questions: [
            { id: 'b11', marks: 8, text: 'Design a fair investigation to determine the effect of pH on amylase activity. Your answer must identify the independent variable, dependent variable, at least three control variables, how the endpoint is detected, and one improvement to reliability.' },
            { id: 'b12', marks: 4, text: 'A student concludes that "fertiliser always increases plant growth" after testing one fertiliser concentration on three plants for five days. Evaluate this conclusion.' }
          ]}
        ]
      },
      {
        id: 'alevel-diagnostic',
        title: 'Part C — Entry Diagnostic: A-Level Biology',
        type: 'diagnostic',
        instructions: 'Recommended time: 120 minutes. Total: 70 marks. This paper samples all eight AQA A-level content areas and emphasises explanation, application, data and synoptic reasoning.',
        totalMarks: 70,
        groups: [
          { heading: 'Section C1 — Biological Molecules & Cells', questions: [
            { id: 'c1', marks: 5, text: 'Explain how the tertiary structure of an enzyme is related to its specificity, and how a change in pH may alter enzyme activity.' },
            { id: 'c2', marks: 5, text: 'Describe how the fluid-mosaic model explains selective transport across cell-surface membranes.' },
            { id: 'c3', marks: 3, text: 'A root-tip preparation contains 420 cells, of which 84 are visibly in mitosis. Calculate the mitotic index and state one reason why this value may not equal the proportion of the cell cycle spent in mitosis.' }
          ]},
          { heading: 'Section C2 — Exchange, Genetics & Energy', questions: [
            { id: 'c4', marks: 6, text: 'Explain how the oxygen dissociation properties of haemoglobin support oxygen loading at the lungs and unloading in actively respiring tissues.' },
            { id: 'c5', marks: 3, text: 'A substitution mutation changes one base in a gene but does not change the amino-acid sequence of the polypeptide. Explain how this is possible.' },
            { id: 'c6', marks: 6, text: 'Compare photophosphorylation and oxidative phosphorylation. Your answer should identify at least one similarity and three biologically important differences.' }
          ]},
          { heading: 'Section C3 — Responses, Populations & Gene Expression', questions: [
            { id: 'c7', marks: 6, text: 'Explain how a resting potential is established across the axon membrane and how an action potential is generated.' },
            { id: 'c8', marks: 4, text: 'In a population, the frequency of a recessive allele q is 0.20. Assuming Hardy-Weinberg conditions, calculate the expected frequencies of the three genotypes.' },
            { id: 'c9', marks: 4, text: 'Explain two ways in which epigenetic modification can alter gene expression without changing the DNA base sequence.' }
          ]},
          { heading: 'Section C4 — Practical, Statistical & Synoptic Reasoning', questions: [
            { id: 'c10', marks: 5, text: 'A student investigates whether a treatment changes the mean growth rate of plants. The treatment and control groups each contain 20 plants. State an appropriate null hypothesis and explain what information is needed before selecting a suitable statistical test.' },
            { id: 'c11', marks: 4, text: 'A graph shows a positive correlation between body mass and blood pressure in 500 adults. Explain why this alone does not show that increasing body mass causes higher blood pressure.' },
            { id: 'c12', marks: 9, text: 'Synoptic challenge: Explain how membranes are important in at least four distinct areas of Biology. Your response should make explicit biological connections rather than list facts.' },
            { id: 'c13', marks: 4, text: 'Experimental design: A student wants to determine the water potential of potato tissue. Outline a valid method and explain how the resulting data can be used to estimate the tissue water potential.' }
          ]}
        ]
      },
      {
        id: 'boundary-diagnostic',
        title: 'Part D — Specification-Boundary Diagnostic',
        type: 'boundary',
        instructions: 'For each statement, classify the most appropriate level: C = GCSE Combined Science; B = GCSE Separate Biology (beyond Combined); H = Higher-tier-only within the relevant GCSE route; A = A-Level; O = outside the expected AQA GCSE/A-level teaching scope for ordinary specification delivery. Some statements may involve more than one feature — choose the most useful classification for tutoring decisions.',
        statements: [
          'Calculate magnification from image size and actual size.',
          'Explain the role of monoclonal antibodies in diagnosis and treatment.',
          'Explain oxidative phosphorylation using chemiosmosis and ATP synthase.',
          'Use the Hardy-Weinberg equation to calculate allele frequencies.',
          'Describe the role of insulin in controlling blood glucose concentration.',
          'Explain how ADH changes the permeability of collecting ducts.',
          'Describe binary fission in bacteria.',
          'Explain DNA replication as semi-conservative.',
          'Explain the induced-fit model of enzyme action in mechanistic detail.',
          'Investigate osmosis using plant tissue.',
          'Explain how restriction endonucleases and DNA ligase are used in gene technology.',
          'Know the detailed intermediates of the Krebs cycle by name.',
          'Use transects and quadrats to investigate distribution and abundance.',
          'Explain how the nephron produces urine through ultrafiltration and selective reabsorption.',
          'Calculate surface-area-to-volume ratio.',
          'Explain the role of histone acetylation and DNA methylation in gene expression.',
          'Describe how vaccination leads to immunological memory.',
          'Explain how auxins influence plant growth responses.',
          'Use a chi-squared test to compare observed and expected frequencies where appropriate.',
          'Name every enzyme involved in glycolysis.',
          'Explain active transport using carrier proteins and energy from respiration.',
          'Explain how myelination affects conduction of action potentials.',
          'Explain the cardiac cycle using pressure changes and valve action.',
          'Interpret a food web and predict effects of changing one population.',
          'Explain how operons control transcription in prokaryotes.',
          'Describe the structure of DNA as a polymer of nucleotides.',
          'Explain the Bohr effect using changes in haemoglobin affinity.',
          'Evaluate evidence for the effect of lifestyle factors on non-communicable disease.',
          'Explain the detailed molecular mechanism of CRISPR-Cas9.',
          'Interpret graphs showing enzyme rate as temperature changes.'
        ]
      },
      {
        id: 'examiner-calibration',
        title: 'Part E — Examiner Calibration Exercise',
        type: 'calibration',
        instructions: 'Mark each student response using the mini mark-scheme principles below. Record your independent mark and rationale first — your assessor will compare it against the official calibration key. The purpose is to see how closely your professional judgement aligns with UK mark-scheme conventions.',
        principles: [
          'Award only what is communicated; do not infer hidden understanding.',
          'Accept scientifically equivalent wording unless precision is essential to the point.',
          'Do not award the same idea twice.',
          'Where a causal chain is required, isolated true statements may not earn full credit.',
          'For "suggest" questions, credit valid application to the stated context even when wording differs from a textbook.'
        ],
        items: [
          { id: 'e1', maxMarks: 3, question: 'Explain why vaccination can protect a population even when some individuals are not vaccinated.', response: '"Vaccines kill the disease. If lots of people are vaccinated, nobody can catch it, so the unvaccinated people are safe."' },
          { id: 'e2', maxMarks: 3, question: 'Explain why increasing temperature from 20°C to 35°C may increase the rate of an enzyme-controlled reaction.', response: '"The enzyme gets more energy and works faster because there are more collisions."' },
          { id: 'e3', maxMarks: 3, question: 'A plant loses mass during a period of darkness. Explain why.', response: '"It cannot photosynthesise but it still respires, so stored organic molecules are broken down and some products leave the plant."' },
          { id: 'e4', maxMarks: 2, question: 'Explain why random sampling is important in a quadrat investigation.', response: '"It makes the experiment fair and stops the scientist choosing where to put the quadrat."' },
          { id: 'e5', maxMarks: 3, question: 'Suggest why a person with damaged villi may lose body mass.', response: '"They cannot digest food properly and therefore do not absorb enough energy."' },
          { id: 'e6', maxMarks: 2, question: 'Explain why antibiotics do not cure influenza.', response: '"Flu is a virus and antibiotics only work on bacteria."' }
        ]
      },
      {
        id: 'teaching-audition',
        title: 'Part F — Teaching Audition: Two Osmosis Lessons',
        type: 'audition',
        purpose: 'This audition tests whether you can adapt the same scientific concept to different learners. Record both lessons and do not edit the recording — your assessor reviews the raw delivery against the Teaching Audition Rubric.',
        lessons: [
          {
            label: 'Lesson A — Struggling Year 10 Learner',
            brief: 'Prepare and deliver a 15-minute one-to-one lesson on osmosis to a Year 10 learner working around Grade 3-4 who confuses diffusion and osmosis and lacks confidence with scientific vocabulary.',
            requirements: [
              'Establish prior knowledge within the first 3 minutes.',
              'Use one clear visual or physical analogy, but explicitly state where the analogy breaks down.',
              'Require the learner to say or construct the definition, not merely listen.',
              'Include one check for understanding that could expose a misconception.',
              'Finish with one exam-style question and feedback.'
            ]
          },
          {
            label: 'Lesson B — Grade 8/9 Learner',
            brief: 'Prepare and deliver a 15-minute lesson on osmosis to a high-attaining Year 11 learner targeting Grade 8/9.',
            requirements: [
              'Move rapidly beyond recall into application.',
              'Use water potential / concentration reasoning only to the depth appropriate to GCSE; do not drift unnecessarily into A-level terminology.',
              'Include interpretation of an unfamiliar plant-tissue result or graph.',
              'Require precise explanation of net movement through a partially permeable membrane.',
              'Finish with a challenging exam-style question and feedback.'
            ]
          }
        ],
        reflectionPrompts: [
          'What did you deliberately change between Lesson A and Lesson B?',
          'Where did the learner have to think rather than merely listen?',
          'What misconception did you look for?',
          'What would you change if you taught each lesson again?'
        ]
      },
      {
        id: 'week1-programme',
        title: 'Part G — Week 1 Learning Programme',
        type: 'programme',
        outcome: 'By the end of Week 1, you can explain the architecture of GCSE/A-level Biology in England, navigate AQA specifications accurately, distinguish key course/tier boundaries, classify assessment demands, and deliver a short Inspire-style diagnostic tutoring sequence.',
        sessions: [
          {
            number: 1, title: 'The UK Secondary Biology Landscape', time: '90 min',
            outcomes: ['Explain GCSE, Combined Science, Separate Sciences, Foundation and Higher tiers.', 'Explain the relationship between GCSE and A-level Biology.', 'Understand the role of exam boards, specifications, mark schemes and examiner reports.', 'Recognise that "knowing Biology" and "teaching the qualification" are related but distinct competencies.'],
            covers: ['9-1 grading and tiering', 'Combined Science vs Separate Sciences', 'Linear assessment', 'Exam-board specifications as the contract', 'Required practicals and practical questions', 'Tutoring versus classroom teaching'],
            task: 'Draw a one-page map of the UK Biology qualification pathway from Year 9/10 to A-level, and explain in 200 words what would go wrong if a tutor taught beyond or below a student\'s specification.'
          },
          {
            number: 2, title: 'How to Read an AQA Specification', time: '90 min',
            outcomes: ['Locate content statements, mathematical requirements and practical requirements.', 'Identify Biology-only / tier-specific boundaries where applicable.', 'Use the specification to make teaching decisions.'],
            covers: ['Workshop: Cell Biology — for each specification statement, write what the student must know/do, likely misconception, likely exam demand, and practical/maths link.', 'Repeat for one topic you scored weakly on in the diagnostic.'],
            task: 'Produce the first two pages of your GCSE Biology Master Specification Map.'
          },
          {
            number: 3, title: 'Assessment Objectives & Exam Logic', time: '90 min',
            outcomes: ['Distinguish AO1 knowledge, AO2 application, and AO3 analysis/evaluation.', 'Recognise that marks may reward reasoning rather than remembered prose.', 'Turn a specification statement into questions at different cognitive levels.'],
            covers: ['Classify 15 original questions by dominant AO.', 'For one topic, write one AO1, one AO2 and one AO3 question.', 'Explain why an excellent AO1 learner may still underperform overall.'],
            task: 'Complete the AO Classification Exercise (Part H3).'
          },
          {
            number: 4, title: 'Foundation, Higher and Grade 8-9 Adaptation', time: '90 min',
            outcomes: ['Adjust depth, scaffolding, vocabulary and cognitive demand without sacrificing scientific accuracy.', 'Avoid teaching A-level detail as a substitute for GCSE challenge.'],
            covers: ['Topic: enzymes. Build three 12-minute lesson plans: Foundation recovery, Higher secure, Grade 8-9 stretch.', 'Each lesson must contain retrieval, explanation, practice and an exit check.'],
            task: 'Submit the three-level lesson plan and a 5-minute recorded excerpt from any one version.'
          },
          {
            number: 5, title: 'Inspire Diagnostic Tutoring I', time: '90 min',
            outcomes: ['Use questioning to locate the point of breakdown.', 'Classify errors before choosing an intervention.', 'End a lesson with evidence of what the learner can now do.'],
            covers: ['The Inspire sequence: RETRIEVE → DIAGNOSE → PREPARE → TEACH → MODEL → PRACTISE → ASSESS → FEEDBACK → PRESCRIBE.'],
            task: 'Deliver a 15-minute diagnostic micro-lesson on enzyme activity to a peer or assessor.'
          }
        ]
      },
      {
        id: 'assignments',
        title: 'Part H — Week 1 Assignments & Evidence Portfolio',
        type: 'evidence',
        items: [
          { key: 'system-map', label: 'UK Biology System Map', desc: 'One-page visual/structured map showing GCSE Combined Science, GCSE Separate Biology, Foundation/Higher tiering, A-level, exam boards, specifications, required practicals, papers and mark schemes.' },
          { key: 'spec-map-cell-biology', label: 'Specification Map — Cell Biology', desc: 'For each subtopic: specification expectation, level/tier boundary, vocabulary, common misconception, practical link, mathematical link, typical AO demand, one tutoring checkpoint question.' },
          { key: 'spec-map-priority-topic', label: 'Specification Map — Diagnostic Priority Topic', desc: 'Same structure, for the topic your diagnostic results flagged as a priority.' },
          { key: 'ao-classification', label: 'AO Classification Exercise', desc: 'Classify 15 questions by dominant Assessment Objective (AO1/AO2/AO3) with a one-line rationale for each.' },
          { key: 'three-level-lesson', label: 'Three-Level Enzyme Lesson', desc: 'Foundation recovery, Higher secure, and Grade 8-9 stretch versions of a 12-minute enzyme-action tutoring segment.' },
          { key: 'microteaching', label: 'Microteaching Recording / Link', desc: 'Link to your recorded diagnostic micro-lesson from Session 5.' },
          { key: 'reflective-brief', label: 'Week 1 Reflective Brief', desc: 'Max 500 words on: the three biggest differences you perceive between your previous teaching context and UK exam-focused tutoring; what will need deliberate adaptation; what strength transfers immediately; what you\'ll change next week.' }
        ]
      },
      {
        id: 'week1-gate',
        title: 'Part J — Competency Map & Week 1 Gate',
        type: 'gate-info',
        domains: [
          'GCSE subject knowledge', 'A-Level subject knowledge', 'Specification literacy', 'Examiner literacy',
          'Adaptive teaching', 'Scientific language', 'Practical reasoning', 'Mathematical Biology',
          'Diagnostic questioning', 'Professional readiness'
        ],
        trafficLightRules: [
          { level: 'Green', desc: 'Secure enough to accelerate — approximately 85%+ or equivalent observed competency.' },
          { level: 'Amber', desc: 'Functional but adaptation required — approximately 65-84% or inconsistent practice.' },
          { level: 'Red', desc: 'Priority retraining — below 65%, a significant misconception, unsafe practice, or inability to explain accurately.' }
        ],
        gateNote: 'Your assessor reviews all Week 1 evidence and records one of three outcomes: proceed to Week 2, proceed with named remediation, or reassess specified components. This decision is always made by a person, never generated automatically from a completion percentage.'
      }
    ]
  },
  'biology-gcse-stage-2': { comingSoon: true, title: 'Specification Mastery', note: 'Stage 2 content is being built from Pack 02 and will follow the same structure as Stage 1.' },
  'biology-gcse-stage-3': { comingSoon: true, title: 'Examiner School', note: 'Stage 3 content is being built from Pack 03.' },
  'biology-gcse-stage-4': { comingSoon: true, title: 'Practical & Mathematical Biology', note: 'Stage 4 content is being built from Pack 04.' }
}

if (typeof window !== 'undefined') window.TutorAcademyContent = TUTOR_ACADEMY_BIOLOGY
if (typeof module !== 'undefined' && module.exports) module.exports = TUTOR_ACADEMY_BIOLOGY
