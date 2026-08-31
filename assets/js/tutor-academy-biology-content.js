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
  'biology-gcse-stage-2': {
    title: 'Specification Mastery',
    subtitle: 'GCSE Biology Specification Mastery & Content Conversion',
    overview: 'This stage converts your existing Biology expertise into precise AQA GCSE tutoring competence across all seven content domains — controlling specification boundaries, Foundation/Higher pitch, Combined/Separate distinctions, common misconceptions, and practical/mathematical links.',
    whyThisMatters: 'A subject expert naturally wants to give the fullest scientific explanation. A GCSE tutor needs a second discipline: restraint. By the end of this stage you should be able to map, explain, differentiate and assess all seven AQA GCSE Biology domains, and demonstrably teach to the specification rather than around it.',
    learningOutcomes: [
      'Map all seven AQA GCSE Biology domains and their Paper 1/Paper 2 placement.',
      'Distinguish core content from Higher-tier and Biology-only extensions.',
      'Identify practical, mathematical and working-scientifically opportunities inside each domain.',
      'Teach the same concept at Foundation, Higher and Grade 8-9 challenge level.',
      'Recognise and repair high-frequency misconceptions using a deliberate protocol, not just correction.',
      'Avoid unnecessary A-level detail while preserving conceptual accuracy.'
    ],
    sections: [
      {
        id: 'specification-control-method',
        title: 'Part A/B — The Inspire Specification-Control Method',
        type: 'method',
        intro: 'The professional shift this stage asks of you: from "I know this Biology" to "I know exactly what this learner must know, how deeply, what misconceptions are likely, how it will be examined, and how I will know they have mastered it."',
        sixLens: [
          'CONTENT — What facts, concepts and processes are explicitly required?',
          'PERFORMANCE — What does "students should be able to…" require them to do?',
          'BOUNDARY — Is it Foundation, Higher, Biology-only, Combined-shared or beyond GCSE?',
          'CONNECTION — Which earlier/later topics does this depend on?',
          'ASSESSMENT — How could this appear as recall, application, data, practical or extended response?',
          'MISCONCEPTION — What plausible wrong model might a student hold?'
        ],
        boundaryTest: [
          'Can I identify whether the point is required at GCSE?',
          'Can I identify whether all students need it or only Higher/Biology-only students?',
          'Can I explain it without drifting into A-level mechanism?',
          'Can I write one exam-style question that tests it?',
          'Can I name one misconception that would produce a wrong answer?'
        ],
        antiOverteachTest: 'Before adding detail, ask: does this detail improve conceptual understanding needed for the GCSE, or am I teaching it because I personally know it?'
      },
      {
        id: 'domain-1-cell-biology',
        title: 'Domain 1 — Cell Biology',
        type: 'domain',
        paper: 'Paper 1',
        scope: 'Cell structure; microscopy; cell specialisation; cell differentiation; chromosomes; mitosis; stem cells; diffusion; osmosis; active transport',
        conceptFamilies: [
          { family: 'Cell structure', control: 'Compare eukaryotic and prokaryotic cells; recognise sub-cellular structures and functions.', boundary: 'Do not turn GCSE into ultrastructure or organelle biochemistry.' },
          { family: 'Microscopy', control: 'Calculate magnification; use standard form where appropriate; interpret images.', boundary: 'Students often confuse image size, actual size and magnification.' },
          { family: 'Cell division', control: 'Link chromosomes, mitosis, growth and repair.', boundary: 'Avoid implying mitosis creates genetic variation.' },
          { family: 'Stem cells', control: 'Evaluate potential benefits/risks and ethical issues.', boundary: 'Separate scientific claims from ethical judgement.' },
          { family: 'Transport', control: 'Differentiate diffusion, osmosis and active transport.', boundary: 'Osmosis concerns water through a partially permeable membrane; active transport requires energy.' }
        ],
        misconceptions: ['All cells have a nucleus.', 'Diffusion requires energy.', 'Osmosis is movement of any solute.', 'Mitosis halves chromosome number.', 'Stem cells are all equally potent.'],
        links: 'Microscopy and osmosis practical links; magnification; surface area-to-volume reasoning.'
      },
      {
        id: 'domain-2-organisation',
        title: 'Domain 2 — Organisation',
        type: 'domain',
        paper: 'Paper 1',
        scope: 'Levels of organisation; digestive system; enzymes; heart and blood vessels; blood; coronary heart disease; plant tissues; transpiration and translocation',
        conceptFamilies: [
          { family: 'Organisation', control: 'Move fluently cell → tissue → organ → organ system.', boundary: 'Students often reverse tissue and organ.' },
          { family: 'Enzymes', control: 'Explain specificity and effects of temperature/pH at GCSE depth.', boundary: 'Avoid unnecessary induced-fit molecular detail unless clarifying.' },
          { family: 'Heart/circulation', control: 'Relate structure to pressure, flow and exchange.', boundary: 'Do not let "arteries carry oxygenated blood" become an absolute rule.' },
          { family: 'Blood', control: 'Link red cells, white cells, platelets and plasma to function.', boundary: 'Distinguish plasma from serum if raised; serum is not normally required.' },
          { family: 'Plants', control: 'Connect xylem/phloem, transpiration and translocation.', boundary: 'Students commonly swap xylem and phloem.' }
        ],
        misconceptions: ['Enzymes die when heated.', 'Veins always carry deoxygenated blood.', 'Food goes through the liver before digestion.', 'Plants get food from the soil.', 'Transpiration and translocation are the same process.'],
        links: 'Food tests/enzyme practicals; rate calculations; graph interpretation; cardiovascular risk evidence.'
      },
      {
        id: 'domain-3-infection-response',
        title: 'Domain 3 — Infection and Response',
        type: 'domain',
        paper: 'Paper 1',
        scope: 'Communicable disease; pathogens; viral/bacterial/fungal/protist examples; human defences; vaccination; antibiotics; drug discovery; monoclonal antibodies; plant disease',
        conceptFamilies: [
          { family: 'Pathogens', control: 'Differentiate pathogen types and transmission.', boundary: 'Do not define all microorganisms as pathogens.' },
          { family: 'Defence', control: 'Separate physical barriers, phagocytosis, antibodies and antitoxins.', boundary: 'Avoid saying antibodies "eat" pathogens.' },
          { family: 'Vaccination', control: 'Explain antigen exposure, memory and faster secondary response at appropriate depth.', boundary: 'Do not say vaccines directly kill pathogens.' },
          { family: 'Antibiotics', control: 'Explain bacterial specificity and resistance selection.', boundary: 'Antibiotics do not treat viral infections.' },
          { family: 'Drug development', control: 'Link preclinical/clinical testing to safety, efficacy and dose.', boundary: 'Students may confuse placebo with control variable.' }
        ],
        misconceptions: ['All bacteria are harmful.', 'Vaccines give you the disease.', 'Antibiotics kill viruses.', 'Resistance happens because individual bacteria try to adapt.', 'White blood cells are the same as antibodies.'],
        links: 'Microbiology practical; evaluation of treatments; application to unfamiliar outbreaks and resistance scenarios.'
      },
      {
        id: 'domain-4-bioenergetics',
        title: 'Domain 4 — Bioenergetics',
        type: 'domain',
        paper: 'Paper 1',
        scope: 'Photosynthesis; limiting factors; uses of glucose; aerobic and anaerobic respiration; exercise; metabolism',
        conceptFamilies: [
          { family: 'Photosynthesis', control: 'Balance word/symbol equations and connect rate to limiting factors.', boundary: 'Students often think plants photosynthesise instead of respiring.' },
          { family: 'Limiting factors', control: 'Interpret graphs and identify changing limiting factor.', boundary: 'Avoid treating one factor as limiting under all conditions.' },
          { family: 'Respiration', control: 'Distinguish aerobic/anaerobic and relate to energy transfer.', boundary: 'Respiration is not breathing.' },
          { family: 'Exercise', control: 'Connect increased energy demand to respiration and physiological responses.', boundary: 'Avoid vague "more oxygen because muscles need it" without causal chain.' },
          { family: 'Metabolism', control: 'Use metabolism as an umbrella for synthesis/breakdown reactions.', boundary: 'Do not reduce metabolism to "how fast you burn calories."' }
        ],
        misconceptions: ['Plants only respire at night.', 'Photosynthesis is how plants breathe.', 'Energy is made in respiration.', 'Lactic acid stays permanently in muscles.', 'More light always increases photosynthesis.'],
        links: 'Photosynthesis practical; rate graphs; extended causal explanations.'
      },
      {
        id: 'domain-5-homeostasis-response',
        title: 'Domain 5 — Homeostasis and Response',
        type: 'domain',
        paper: 'Paper 2',
        scope: 'Homeostasis; nervous system; reflexes; brain/eye (Biology-only areas); endocrine system; blood glucose; diabetes; reproduction; fertility control; plant hormones; water balance/kidney',
        conceptFamilies: [
          { family: 'Homeostasis', control: 'Explain receptor → coordination centre → effector and negative feedback.', boundary: 'Do not define homeostasis as keeping everything constant.' },
          { family: 'Nervous system', control: 'Trace stimulus-response pathways and reflex arcs.', boundary: 'Students confuse sensory and motor neurones.' },
          { family: 'Hormones', control: 'Compare nervous and endocrine coordination.', boundary: 'Hormones travel in blood; they are not nerve impulses.' },
          { family: 'Glucose control', control: 'Explain insulin/glucagon roles at required tier depth.', boundary: 'Avoid saying insulin "turns glucose into insulin."' },
          { family: 'Reproduction', control: 'Link hormones to menstrual cycle, contraception and fertility treatment.', boundary: 'Keep sequence and feedback relationships clear.' }
        ],
        misconceptions: ['Homeostasis keeps conditions perfectly constant.', 'Reflexes always involve the brain first.', 'Hormones travel down nerves.', 'Insulin removes glucose from the body.', 'All contraceptives prevent ovulation.'],
        links: 'Reaction-time practical; interpreting hormone graphs; evaluating treatments; plant-response practical for Biology-only.',
        separateBiologyNote: 'The brain/eye content in this domain is Biology-only — confirm your candidate\'s route before teaching it.'
      },
      {
        id: 'domain-6-inheritance-variation-evolution',
        title: 'Domain 6 — Inheritance, Variation and Evolution',
        type: 'domain',
        paper: 'Paper 2',
        scope: 'Sexual/asexual reproduction; meiosis; DNA/genome; genetic inheritance; inherited disorders; variation; evolution; selective breeding; genetic engineering; cloning; fossils; resistant bacteria; classification',
        conceptFamilies: [
          { family: 'Reproduction', control: 'Contrast sexual and asexual reproduction and implications for variation.', boundary: 'Mitosis and meiosis must not be conflated.' },
          { family: 'DNA/genome', control: 'Connect gene, chromosome and genome at GCSE depth.', boundary: 'Avoid unnecessary transcription/translation detail beyond specification.' },
          { family: 'Inheritance', control: 'Use genetic diagrams and probability appropriately.', boundary: 'Dominant does not mean common or better.' },
          { family: 'Evolution', control: 'Explain selection through existing variation and differential survival/reproduction.', boundary: 'Individuals do not evolve because they need to.' },
          { family: 'Biotechnology', control: 'Evaluate selective breeding/genetic engineering/cloning.', boundary: 'Separate mechanism, benefit, risk and ethical claim.' }
        ],
        misconceptions: ['Dominant alleles are always more common.', 'Evolution gives organisms what they need.', 'Meiosis makes identical cells.', 'Genes and chromosomes are the same thing.', 'Antibiotics cause useful resistance mutations.'],
        links: 'Genetic crosses and probability; evaluating evidence; antibiotic-resistance application; classification evidence.'
      },
      {
        id: 'domain-7-ecology',
        title: 'Domain 7 — Ecology',
        type: 'domain',
        paper: 'Paper 2',
        scope: 'Communities; abiotic/biotic factors; adaptations; interdependence; competition; sampling; material cycles; decomposition; biodiversity; human impacts; food security',
        conceptFamilies: [
          { family: 'Ecosystems', control: 'Connect organism, population, community and ecosystem.', boundary: 'Students often use population/community interchangeably.' },
          { family: 'Factors', control: 'Distinguish abiotic from biotic and link to distribution.', boundary: 'Lists without causal explanation are weak.' },
          { family: 'Sampling', control: 'Explain quadrats, transects, random sampling and estimation.', boundary: '"More quadrats makes it fair" needs precision: reliability/representativeness.' },
          { family: 'Cycles', control: 'Explain water/carbon cycles and decomposer role.', boundary: 'Matter cycles; energy flows.' },
          { family: 'Biodiversity', control: 'Evaluate human impacts and conservation strategies.', boundary: 'Avoid assuming every intervention has only benefits.' }
        ],
        misconceptions: ['Energy is recycled in ecosystems.', 'All competition is between different species.', 'A quadrat measures population exactly.', 'Decomposers only eat dead animals.', 'Biodiversity means the number of animals.'],
        links: 'Quadrat/transect practical; mean/area estimates; decay practical; graph/data evaluation; human-impact arguments.'
      },
      {
        id: 'cross-domain-synthesis',
        title: 'Part J — Cross-Domain Synthesis & Tutoring Intelligence',
        type: 'synthesis',
        intro: 'Top GCSE performance requires students to retrieve across topics. Teach Biology as one connected system rather than seven isolated chapters.',
        connections: [
          { anchor: 'Surface area', links: 'Cells ↔ villi ↔ alveoli ↔ roots ↔ exchange efficiency' },
          { anchor: 'Enzymes', links: 'Organisation ↔ digestion ↔ respiration/photosynthesis ↔ homeostasis' },
          { anchor: 'Transport', links: 'Cell membranes ↔ blood ↔ xylem/phloem ↔ kidney' },
          { anchor: 'Variation', links: 'Meiosis ↔ inheritance ↔ evolution ↔ antibiotic resistance' },
          { anchor: 'Energy', links: 'Photosynthesis ↔ respiration ↔ food chains ↔ exercise' },
          { anchor: 'Homeostasis', links: 'Enzymes ↔ nervous/endocrine coordination ↔ kidney ↔ glucose control' },
          { anchor: 'Evidence', links: 'Practical methods ↔ sampling ↔ drug trials ↔ disease-risk correlations' }
        ],
        repairProtocol: ['ELICIT — make the student state or predict.', 'EXPOSE — produce evidence/example the misconception cannot explain.', 'REBUILD — teach the correct causal model.', 'CHECK — ask a near-transfer question.', 'TRANSFER — ask an unfamiliar-context question.'],
        repairNote: 'Do not correct every misconception by simply telling the student the right sentence. A durable correction requires the learner to notice why the previous mental model fails.'
      },
      {
        id: 'tier-route-drills',
        title: 'Part K — Route & Tier Conversion Drills',
        type: 'drills',
        instructions: 'For each scenario, write what you would teach, what you would deliberately omit, one model question, and one mastery check.',
        scenarios: [
          { id: 'k1', label: 'Year 10 Foundation', prompt: 'Osmosis — learner struggles with concentration language.' },
          { id: 'k2', label: 'Year 11 Higher', prompt: 'Osmosis — learner can recall definition but fails unfamiliar contexts.' },
          { id: 'k3', label: 'Year 11 Separate Biology Higher', prompt: 'Kidney/water balance — target grade 8.' },
          { id: 'k4', label: 'Year 10 Combined Science', prompt: 'Monoclonal antibodies are mentioned by a sibling studying Separate Biology.' },
          { id: 'k5', label: 'Year 11 Higher', prompt: 'Evolution — student says organisms adapt because they need to survive.' },
          { id: 'k6', label: 'Year 11 Foundation', prompt: 'Ecology — student cannot distinguish population, community and ecosystem.' }
        ],
        classificationTable: {
          instructions: 'Classify each teaching choice: Overteach / Underteach / Just right / Scientifically wrong — with a one-line justification.',
          items: [
            'Explain ATP synthase during GCSE respiration.',
            'Teach that respiration transfers energy rather than "creates energy".',
            'Ignore active transport because it is difficult for Foundation students.',
            'Teach every glycolysis intermediate at GCSE.',
            'Use genetic diagrams and probability for inheritance questions.',
            'Teach that dominant means "stronger".',
            'Use "plants make glucose in photosynthesis" then connect uses of glucose.',
            'Teach antibody specificity when explaining vaccination.'
          ]
        }
      },
      {
        id: 'week2-assessment',
        title: 'Part L — Week 2 Assessment',
        type: 'week2-assessment',
        specControl: {
          heading: 'L1 — Specification Control (30 marks, 35 minutes, no notes)',
          questions: [
            { id: 'l1-1', marks: 4, text: 'Name the four subject areas examined on AQA GCSE Biology Paper 1.' },
            { id: 'l1-2', marks: 3, text: 'Name the three principal subject areas examined on Paper 2.' },
            { id: 'l1-3', marks: 3, text: 'A Higher student asks for the molecular mechanism of oxidative phosphorylation. Explain how you would handle this without confusing specification depth.' },
            { id: 'l1-4', marks: 4, text: 'Give two examples of Biology content where a tutor must check Combined/Separate boundaries before teaching.' },
            { id: 'l1-5', marks: 3, text: 'Explain one way a "students should be able to" statement changes lesson design compared with a pure knowledge statement.' },
            { id: 'l1-6', marks: 3, text: 'A student says dominant alleles are the most common. Diagnose and correct the misconception.' },
            { id: 'l1-7', marks: 4, text: 'Write one AO2-style question on photosynthesis and explain why it is AO2.' },
            { id: 'l1-8', marks: 3, text: 'Write one practical/data question on ecology and identify the skill it tests.' },
            { id: 'l1-9', marks: 3, text: 'Explain the difference between teaching more detail and teaching greater challenge.' }
          ]
        },
        misconceptionClinic: {
          heading: 'L2 — Misconception Clinic (20 marks)',
          instructions: 'For each statement (4 marks each): identify what is wrong, give the corrected model, and write one question that checks whether the misconception is repaired.',
          items: [
            { id: 'l2-1', domain: 'Bioenergetics', statement: '"Plants do not respire when they are photosynthesising."' },
            { id: 'l2-2', domain: 'Infection/Evolution', statement: '"Antibiotics make bacteria mutate so they become resistant."' },
            { id: 'l2-3', domain: 'Homeostasis', statement: '"Homeostasis means the body keeps everything at exactly the same value."' },
            { id: 'l2-4', domain: 'Organisation', statement: '"A vein is a vessel carrying deoxygenated blood."' },
            { id: 'l2-5', domain: 'Cell Biology', statement: '"Osmosis is water moving from high concentration to low concentration."' }
          ]
        },
        microteaching: {
          heading: 'L3 — 20-Minute Microteaching',
          brief: 'Teach "How vaccination protects individuals and populations" to a Year 11 Higher student currently working at Grade 6 and targeting Grade 8. The learner can define vaccination but struggles to construct causal explanations in unfamiliar contexts.',
          requirements: ['A 2-3 minute retrieval/diagnostic opening.', 'A precise explanation at GCSE Higher depth.', 'At least three questions requiring student thinking, not just recall.', 'One misconception check.', 'One AO2 unfamiliar-context question.', 'A final mastery check and explicit next step.']
        }
      },
      {
        id: 'week2-gate',
        title: 'Part M — Assessor Rubric & Week 2 Gate',
        type: 'gate-info',
        domains: ['Cell Biology', 'Organisation', 'Infection & Response', 'Bioenergetics', 'Homeostasis & Response', 'Inheritance/Variation/Evolution', 'Ecology', 'Tier/route control', 'Misconception diagnosis', 'Exam/application design'],
        trafficLightRules: [
          { level: 'Green', desc: 'Domain intelligence sheet complete and accurate; no repeated boundary errors.' },
          { level: 'Amber', desc: 'Functional but some imprecision or inconsistent boundary control.' },
          { level: 'Red', desc: 'Material scientific error, or repeated Foundation/Higher or Combined/Separate confusion.' }
        ],
        gateNote: 'Decision rule: PASS if all critical gates are met (7 domain sheets complete, Specification Control ≥90%, Misconception Clinic ≥85%, microteaching ≥4/5, no critical scientific-accuracy errors). CONDITIONAL PASS for one remediable non-critical weakness with a written 72-hour remediation task. HOLD for scientific inaccuracy, repeated boundary errors, or below-minimum microteaching. This decision is always made by your assessor, never generated automatically.'
      }
    ]
  },
  'biology-gcse-stage-3': {
    title: 'Examiner School',
    subtitle: 'Question Anatomy, Command Words, AO Thinking, Marking Calibration, Extended Response',
    overview: 'A strong Biology teacher does not automatically become a strong GCSE examination tutor. This stage trains you to read questions as an examiner reads them, identify the cognitive demand behind the wording, predict mark-scheme logic, diagnose why students lose marks, and teach those skills explicitly.',
    whyThisMatters: 'Week 3 is the point at which UK curriculum knowledge is converted into examination intelligence. By the end you should be able to teach students how marks are actually won, not merely how Biology is remembered.',
    learningOutcomes: [
      'Use AQA science command words accurately and teach them explicitly.',
      'Identify the biological knowledge a question requires and the additional application step.',
      'Recognise when a response is biologically true but examination-incomplete.',
      'Distinguish AO1 recall, AO2 application and AO3 analysis/evaluation.',
      'Mark student responses consistently and justify each awarded or withheld mark.',
      'Diagnose errors using the Inspire K-M-A-Q-L-Math-P-E taxonomy.',
      'Teach six-mark and data-response questions through modelling, guided practice and feedback.'
    ],
    sections: [
      {
        id: 'four-lens-method',
        title: 'The Four-Lens Method',
        type: 'four-lens',
        mantra: 'Do not ask only: "Does the student know the topic?" Ask: "Can the student recognise what this question is demanding and convert knowledge into mark-worthy evidence?"',
        lenses: [
          { lens: 'COMMAND', question: 'What exactly must the student do?', action: 'Translate the command word into the required response behaviour.' },
          { lens: 'CONTENT', question: 'What Biology must be retrieved?', action: 'Identify the relevant specification knowledge.' },
          { lens: 'CONTEXT', question: 'What unfamiliar data, organism, graph or scenario changes the task?', action: 'Show the student how to apply known Biology to the new situation.' },
          { lens: 'MARKS', question: 'How much evidence or reasoning is expected?', action: 'Use the mark allocation as a rough guide to breadth, steps and precision.' }
        ],
        workedExample: 'A runner\'s breathing rate remains high for several minutes after a 400m sprint. Explain why. [4] — Command: explain (give biological reasons, connect cause to consequence). Content: respiration, oxygen supply, anaerobic respiration, lactic acid/oxygen debt at GCSE depth. Context: post-exercise recovery, not exercise itself. Marks: likely requires a connected chain rather than four disconnected facts.',
        task: 'Write a four-mark model answer to the worked example above, then identify two plausible student answers that are biologically relevant but would likely underperform because the reasoning chain is incomplete.'
      },
      {
        id: 'command-word-academy',
        title: 'Command Word Academy',
        type: 'command-words',
        intro: 'AQA defines command words as the words and phrases that tell students how they should answer. Consult the current official AQA GCSE Science command-word resource alongside this training material.',
        commands: [
          { word: 'Give / Name / State', meaning: 'Provide a short, precise response.', failure: 'Student wastes time explaining or adds contradictory material.' },
          { word: 'Describe', meaning: 'Give an accurate account of what is seen, happens or is shown.', failure: 'Student gives reasons instead of describing.' },
          { word: 'Explain', meaning: 'Make the reason or mechanism clear.', failure: 'Student lists facts without causal links.' },
          { word: 'Compare', meaning: 'Give relevant similarities and/or differences between both items.', failure: 'Student writes about only one item.' },
          { word: 'Calculate', meaning: 'Use given numerical information to obtain an answer.', failure: 'No working, wrong units, wrong substitution.' },
          { word: 'Determine', meaning: 'Use supplied information/data to obtain the answer.', failure: 'Student ignores the provided evidence.' },
          { word: 'Suggest', meaning: 'Apply Biology to a new or unfamiliar situation.', failure: 'Student panics because the exact example was not memorised.' },
          { word: 'Evaluate', meaning: 'Use evidence plus knowledge to weigh strengths/limitations and reach a judgement.', failure: 'One-sided description with no judgement.' },
          { word: 'Justify', meaning: 'Use evidence supplied to support a conclusion/choice.', failure: 'Assertion without evidence.' },
          { word: 'Predict', meaning: 'Give a biologically plausible outcome.', failure: 'Outcome stated with no link to the pattern/context when reasoning is needed.' },
          { word: 'Design / Plan', meaning: 'Set out how an investigation should be carried out.', failure: 'Generic method lacking variables, measurements or control.' }
        ],
        drill: [
          { id: 'cs1', stem: 'The graph shows glucose concentration before and after a meal.', commands: 'Describe / Explain' },
          { id: 'cs2', stem: 'Two plants were grown at different light intensities.', commands: 'Compare / Explain' },
          { id: 'cs3', stem: 'A new antibiotic reduced bacterial growth in one trial.', commands: 'Suggest / Evaluate' },
          { id: 'cs4', stem: 'A farmer chooses variety B rather than variety A.', commands: 'Identify / Justify' }
        ]
      },
      {
        id: 'ao-thinking',
        title: 'Assessment Objective Thinking',
        type: 'ao-thinking',
        intro: 'The candidate must learn to see the difference between knowing, applying and analysing. These labels are training heuristics, not a substitute for the specification or official paper blueprint.',
        aos: [
          { ao: 'AO1', shorthand: 'KNOW', desc: 'Recall, select, describe or demonstrate knowledge and understanding.' },
          { ao: 'AO2', shorthand: 'USE', desc: 'Apply knowledge and understanding to familiar or unfamiliar contexts, including practical and mathematical settings.' },
          { ao: 'AO3', shorthand: 'JUDGE', desc: 'Analyse information, interpret evidence, draw conclusions, evaluate methods or make judgements.' }
        ],
        warning: 'Command words can be useful clues, but they are not a perfect one-to-one code for assessment objectives. Read the entire question, data and context.',
        drillItems: [
          'State the function of ribosomes.', 'Explain why a root hair cell has a large surface area.',
          'Use the graph to determine the optimum temperature.', 'Evaluate the student\'s conclusion from the results.',
          'Describe what happens to chromosome number during mitosis.', 'Suggest why the patient\'s heart rate increased after the drug.',
          'Calculate percentage change in mass.', 'Compare the distributions shown in two histograms.',
          'Give two ways white blood cells defend the body.', 'Explain the results of an unfamiliar osmosis experiment.',
          'Identify an anomaly in the table.', 'State the word equation for photosynthesis.',
          'Use evidence to justify which habitat has greater biodiversity.', 'Suggest why a mutation may not change phenotype.',
          'Describe the trend shown by the line graph.', 'Explain how insulin reduces blood glucose concentration.',
          'Evaluate whether the sample size is sufficient.', 'Name the vessel carrying blood from heart to lungs.',
          'Predict the effect of reducing light intensity on photosynthesis.', 'Calculate mean number of organisms per quadrat.'
        ]
      },
      {
        id: 'question-anatomy-lab',
        title: 'Question Anatomy Laboratory',
        type: 'question-lab',
        instructions: 'Deconstruct each original Inspire question: identify command, content, context, likely AO emphasis, and what a high-quality answer must contain.',
        questions: [
          { id: 'qa1', marks: 4, text: 'A student places equal-sized potato cylinders into sucrose solutions of different concentrations. Explain why some cylinders gain mass and others lose mass.' },
          { id: 'qa2', marks: 4, text: 'A new pesticide kills most insects in a field. Suggest two ways this could affect bird populations in the field.' },
          { id: 'qa3', marks: 3, text: 'The mean number of stomata per mm² is higher on the lower leaf surface than the upper surface. Suggest an advantage of this distribution.' },
          { id: 'qa4', marks: 4, text: 'A patient has a narrowing in a coronary artery. Explain how this can increase the risk of damage to heart muscle.' },
          { id: 'qa5', marks: 4, text: 'Two antibiotics produce inhibition zones of 18mm and 12mm. Evaluate the conclusion that the first antibiotic is always more effective.' },
          { id: 'qa6', marks: 6, text: 'The population of rabbits rises sharply and then falls. Use ecological principles to suggest reasons for this pattern.' }
        ]
      },
      {
        id: 'suggest-clinic',
        title: 'The "Suggest" Clinic',
        type: 'suggest-clinic',
        intro: 'AQA uses "suggest" where students must apply knowledge and understanding to a new situation. The unfamiliar surface details are part of the test, not a sign that the content is outside the course.',
        protocol: [
          { step: 'S — Strip the story', prompt: 'What is biologically important in the scenario?' },
          { step: 'C — Connect to known Biology', prompt: 'Which topic or mechanism does this resemble?' },
          { step: 'O — Offer a plausible mechanism', prompt: 'What could cause the observation?' },
          { step: 'P — Pin it to evidence', prompt: 'Which detail in the question supports your idea?' },
          { step: 'E — Express cautiously', prompt: 'Use scientifically defensible language; do not claim more than the evidence allows.' }
        ],
        questions: [
          { id: 'sc1', marks: 3, text: 'A deep-sea fish has unusually high concentrations of unsaturated lipids in its cell membranes. Suggest why this may be advantageous in very cold water.' },
          { id: 'sc2', marks: 2, text: 'A plant growing beside a road has fewer lichens on its bark than a similar plant in a rural area. Suggest one explanation.' },
          { id: 'sc3', marks: 4, text: 'A patient taking an antibiotic stops treatment after two days when symptoms improve. Suggest how this behaviour could contribute to antibiotic resistance.' },
          { id: 'sc4', marks: 5, text: 'A population of insects on a dark volcanic island becomes darker over many generations. Suggest how this change could arise by natural selection.' },
          { id: 'sc5', marks: 2, text: 'A student finds that enzyme activity falls at very high substrate concentration. Suggest one reason other than shortage of substrate.' }
        ]
      },
      {
        id: 'data-graph-school',
        title: 'Data, Graph and Evidence School',
        type: 'data-school',
        intro: 'Many GCSE students can recite Biology but lose marks when the same knowledge appears inside a table, graph or unfamiliar investigation. Teach a repeatable reading process.',
        protocol: ['R — Read axes/headings: identify variables, units and categories.', 'E — Establish pattern: state the overall trend before explaining it.', 'A — Anchor with data: select numerical evidence when the question requires it.', 'D — Detect anomalies: notice exceptions or irregular results.', 'D — Decide what Biology applies: link pattern to mechanism.', 'A — Avoid overclaiming: correlation is not automatically causation.', 'T — Test the conclusion: ask whether evidence genuinely supports it.', 'A — Assess limitations: consider sample size, repeats, controls, range and measurement quality.'],
        datasets: [
          {
            title: 'Mini dataset 1 — Enzyme rate',
            table: { headers: ['Temperature (°C)', '10', '20', '30', '40', '50', '60'], row: ['Rate (units)', '1.2', '2.1', '3.8', '5.2', '2.7', '0.6'] },
            questions: [
              { id: 'ds1', marks: 2, text: 'Describe the pattern in the results.' },
              { id: 'ds2', marks: 3, text: 'Explain the change in rate between 20°C and 40°C.' },
              { id: 'ds3', marks: 3, text: 'Explain the change between 40°C and 60°C.' },
              { id: 'ds4', marks: 3, text: 'A student says "40°C is the optimum temperature for this enzyme." Evaluate this statement.' }
            ]
          },
          {
            title: 'Mini dataset 2 — Field sampling',
            table: { headers: ['Site', 'Mean daisies per m²', 'Range'], rows: [['A', '14', '3-25'], ['B', '16', '15-18'], ['C', '6', '0-13']] },
            questions: [
              { id: 'ds5', marks: 2, text: 'Which site gives the most consistent results? Justify your answer.' },
              { id: 'ds6', marks: 2, text: 'Explain why comparing only the means could be misleading.' }
            ]
          }
        ]
      },
      {
        id: 'extended-response',
        title: 'Extended Response and Six-Mark Questions',
        type: 'extended-response',
        intro: 'A six-mark response is not "write everything you know." The student must select relevant Biology, organise it logically and respond to the exact context.',
        chain: [
          { letter: 'C', label: 'Command', meaning: 'What form must the answer take?' },
          { letter: 'H', label: 'Headline idea', meaning: 'What is the overall biological explanation or argument?' },
          { letter: 'A', label: 'Accurate points', meaning: 'Select relevant, precise Biology.' },
          { letter: 'I', label: 'Interlink', meaning: 'Connect cause → mechanism → consequence rather than listing.' },
          { letter: 'N', label: 'Nail the context', meaning: 'Refer back to the organism, data, treatment or investigation in the question.' }
        ],
        worked: { id: 'er-worked', marks: 6, text: 'Explain how vaccination can reduce the spread of a communicable disease in a population.' },
        independent: [
          { id: 'er1', marks: 6, text: 'Explain how the structure of the small intestine is adapted for efficient absorption of digested food molecules.' },
          { id: 'er2', marks: 6, text: 'A student investigates the effect of light intensity on photosynthesis using pondweed. Evaluate the investigation and suggest improvements.' },
          { id: 'er3', marks: 6, text: 'Explain how natural selection can lead to the evolution of antibiotic-resistant bacteria.' }
        ]
      },
      {
        id: 'marking-calibration-lab',
        title: 'Marking Calibration Laboratory',
        type: 'calibration-lab',
        rule: 'Mark the response that was written, not the response you wish the student had written. Do not award marks for inferred knowledge unless the wording genuinely demonstrates it.',
        sets: [
          {
            title: 'Calibration Set A', question: 'Explain why a person breathes faster during vigorous exercise.', maxMarks: 4,
            students: [
              { id: 'A', text: 'The muscles need more energy so they respire faster. More oxygen is needed for aerobic respiration and more carbon dioxide is produced, so breathing increases to bring in oxygen and remove carbon dioxide.' },
              { id: 'B', text: 'Because the body is working harder and needs air.' },
              { id: 'C', text: 'More glucose is made in the lungs so the muscles can respire.' },
              { id: 'D', text: 'Muscles contract more. Respiration increases. Oxygen is used faster. Carbon dioxide increases. Breathing rate rises.' }
            ]
          },
          {
            title: 'Calibration Set B', question: 'Suggest why a plant kept in darkness for several days loses mass.', maxMarks: 3,
            students: [
              { id: 'E', text: 'It cannot photosynthesise but it continues respiration, so stored organic molecules are broken down and some products leave the plant.' },
              { id: 'F', text: 'It dies because there is no light.' },
              { id: 'G', text: 'No photosynthesis occurs. The plant still respires and uses stored glucose.' },
              { id: 'H', text: 'Water evaporates because the plant is in darkness.' }
            ]
          }
        ]
      },
      {
        id: 'error-taxonomy',
        title: 'Inspire Error Taxonomy',
        type: 'error-taxonomy',
        intro: 'Every lost mark should be diagnosed before remediation. The same score can conceal entirely different learning needs.',
        drill: [
          { id: 'et1', case: 'Student defines osmosis as "movement of water from high concentration to low concentration".' },
          { id: 'et2', case: 'Student knows insulin lowers blood glucose but cannot explain an unfamiliar insulin-pump graph.' },
          { id: 'et3', case: 'Student answers "describe" by explaining why the trend occurs and never states the trend.' },
          { id: 'et4', case: 'Student writes 0.4 instead of 40% after correctly calculating a decimal fraction.' },
          { id: 'et5', case: 'Student says "the results prove fertiliser causes growth" from one small observational dataset.' },
          { id: 'et6', case: 'Student writes "the heart pumps oxygen around the body" when discussing blood transport.' }
        ]
      },
      {
        id: 'hundred-mark-lab',
        title: 'The 100-Mark Examiner Laboratory',
        type: '100-mark-lab',
        intro: 'Across this stage, complete 100 marks of carefully selected official past-paper questions or approved Inspire equivalents. The purpose is not score accumulation; it is deliberate analysis.',
        captureFields: ['Command — exact command word or instruction', 'Content — specification knowledge required', 'Context — what makes the question familiar/unfamiliar', 'AO demand — likely dominant cognitive demand', 'Model answer — concise response that earns available marks', 'Mark-scheme surprise — anything accepted/rejected you did not predict', 'Student trap — most likely way a learner loses marks', 'Teaching move — how you would prevent or repair that error'],
        reflectionPrompt: 'Identify the three examination patterns that most changed your understanding of GCSE Biology assessment.'
      },
      {
        id: 'examiner-microteaching',
        title: 'Examiner School Microteaching',
        type: 'microteaching',
        intro: 'Deliver a 20-minute tutoring segment to a learner or simulated learner. The objective is not to lecture about exam technique — it is to visibly improve performance on a difficult question.',
        structure: [
          { minutes: '0-3', action: 'Diagnostic attempt: student answers an unfamiliar Biology question without help.' },
          { minutes: '3-6', action: 'Diagnose the dominant error using the Inspire taxonomy.' },
          { minutes: '6-10', action: 'Model question deconstruction using Command-Content-Context-Marks.' },
          { minutes: '10-15', action: 'Guided attempt on a parallel question.' },
          { minutes: '15-18', action: 'Independent attempt on a second parallel question.' },
          { minutes: '18-20', action: 'Feedback, metacognitive recap and next prescription.' }
        ],
        focusOptions: ['Suggest/application question', 'Explain/cause-and-effect question', 'Data/evaluation question', 'Six-mark extended response'],
        planFields: ['Diagnostic question', 'Likely error', 'Model question', 'Guided question', 'Independent question', 'Success criterion', 'Follow-up prescription']
      },
      {
        id: 'formal-week3-assessment',
        title: 'Week 3 Formal Assessment',
        type: 'formal-assessment',
        instructions: 'Time: 75 minutes. Total: 60 marks. Closed notes unless your assessor specifies otherwise.',
        sections: [
          { heading: 'Section A — Command and AO literacy [15]', questions: [
            { id: 'fa1', marks: 2, text: 'For "compare", state what must appear in a high-quality response.' },
            { id: 'fa2', marks: 2, text: 'Explain the difference between "describe" and "explain".' },
            { id: 'fa3', marks: 2, text: 'What does "suggest" usually require a student to do?' },
            { id: 'fa4', marks: 2, text: 'Classify: "Evaluate whether the conclusion is supported by the data." Give AO and reason.' },
            { id: 'fa5', marks: 2, text: 'Classify: "State two functions of the liver." Give AO and reason.' },
            { id: 'fa6', marks: 2, text: 'Classify: "Use the graph to explain why the student chose 35°C." Give AO and reason.' },
            { id: 'fa7', marks: 3, text: 'Give one reason command words alone cannot always determine AO.' }
          ]},
          { heading: 'Section B — Question anatomy [15]', questions: [
            { id: 'fa8', marks: 5, text: 'A drug blocks receptors for a hormone on liver cells. Suggest how this could affect control of blood glucose concentration. Identify command, content, context and likely reasoning chain, then write a model answer.' },
            { id: 'fa9', marks: 5, text: 'A student concludes that fertiliser X causes greater plant growth because the treated plants were taller after four weeks. Evaluate the conclusion.' },
            { id: 'fa10', marks: 5, text: 'A woodland has fewer species after a new road is built through it. Suggest biological reasons for this change.' }
          ]},
          { heading: 'Section C — Marking calibration [15]', questions: [
            { id: 'fa11', marks: 6, text: 'Question: "Explain why a person with severe diarrhoea may become dehydrated. [4]" Student A: "Water is lost in watery faeces faster than it is replaced, reducing body water." Student B: "They go to the toilet a lot so they get dehydrated." Student C: "Less water is absorbed from the intestine and more water leaves the body in faeces, so body water falls." Award marks and justify your decisions.' },
            { id: 'fa12', marks: 3, text: 'Identify the dominant error code for Student B (above) and propose one tutoring intervention.' },
            { id: 'fa13', marks: 6, text: 'Write an improved four-mark answer suitable for modelling to a student.' }
          ]},
          { heading: 'Section D — Extended response coaching [15]', questions: [
            { id: 'fa14', marks: 15, text: 'A student writes the response below to a six-mark question about natural selection: "Some bacteria become resistant because they need to survive the antibiotic. They then get used to it and pass resistance to their babies." Diagnose the biological and examination problems, then outline how you would coach the student to produce a high-quality answer.' }
          ]}
        ]
      },
      {
        id: 'self-evaluation',
        title: 'Candidate Self-Evaluation',
        type: 'self-evaluation',
        competencies: ['Command-word fluency', 'AO recognition', 'Question deconstruction', 'Application / suggest coaching', 'Data interpretation', 'Marking calibration', 'Extended response coaching', 'Error diagnosis'],
        prompts: ['My three strongest gains this week', 'My two priority gaps before GCSE clearance', 'One change I will make immediately in my tutoring']
      }
    ]
  },
  'biology-gcse-stage-4': {
    title: 'Practical & Mathematical Biology',
    subtitle: 'Required Practicals, Experimental Design, Maths, Data, Evaluation & GCSE Clearance',
    overview: 'This is the GCSE clearance stage. It integrates practical science, mathematical Biology, data interpretation, experimental design and evaluation, then tests whether you are ready for provisional independent deployment with Inspire GCSE Biology students.',
    whyThisMatters: 'The standard: move from "I know how this practical works" to "I can teach a pupil to reason through any practical or mathematical Biology question the examiner places in front of them." Clearance is an Inspire internal quality designation — it does not confer Qualified Teacher Status in England.',
    learningOutcomes: [
      'Teach all ten AQA GCSE Biology required practical activities through purpose, method, variables, data, evaluation and exam transfer.',
      'Distinguish independent, dependent and control variables and critique weak experimental designs.',
      'Teach mathematical requirements: ratios, percentages, means, standard form, significant figures, gradients, rates, sampling, probability and geometry.',
      'Diagnose whether a pupil\'s difficulty is biological, mathematical, graphical, practical or linguistic.',
      'Interpret unfamiliar tables, graphs and experimental scenarios without overclaiming.',
      'Evaluate validity, repeatability, reproducibility, accuracy, precision and uncertainty appropriately.'
    ],
    sections: [
      {
        id: 'six-lens-practical',
        title: 'The Inspire Six-Lens Method (Practical Biology)',
        type: 'six-lens',
        intro: 'For every required practical, teach beyond memorising a recipe.',
        lenses: [
          { lens: 'PURPOSE', question: 'What biological relationship or claim is being investigated?' },
          { lens: 'DESIGN', question: 'What is changed, measured and controlled?' },
          { lens: 'METHOD', question: 'What must actually be done, and why?' },
          { lens: 'DATA', question: 'What should be recorded, processed and displayed?' },
          { lens: 'EVALUATION', question: 'What limits confidence and how can the design improve?' },
          { lens: 'TRANSFER', question: 'How might the examiner disguise the same reasoning in an unfamiliar context?' }
        ],
        task: 'Choose one practical you already teach confidently. Reframe it using all six lenses. Your final paragraph must explain how you would prevent a student from simply memorising steps.'
      },
      {
        id: 'required-practicals',
        title: 'The 10 Required Practicals',
        type: 'practicals-set',
        note: 'AQA GCSE Biology 8461 specifies ten required practical activities. Practicals 1, 3, 4, 5, 6, 7 and 9 are common with Combined Science; practicals 2, 8 and 10 are Biology-only.',
        practicals: [
          { id: 'rp1', number: 1, title: 'Microscopy', purpose: 'Use a light microscope to observe, draw and label plant and animal cells, including a magnification scale.', mathsLink: 'Magnification; scale; biological drawing; estimation.', traps: 'Confusing image size with actual size; missing units; decorative rather than scientific drawings.' },
          { id: 'rp2', number: 2, title: 'Antiseptics/Antibiotics', biologyOnly: true, purpose: 'Investigate effects on bacterial growth using agar plates and zones of inhibition.', mathsLink: 'Area πr²; aseptic technique; controls; safe culture practice.', traps: 'Assuming largest zone proves "best medicine" without controlling dose/concentration; unsafe discussion of incubation.' },
          { id: 'rp3', number: 3, title: 'Osmosis', purpose: 'Investigate effects of salt/sugar concentration on mass of plant tissue.', mathsLink: 'Percentage change; means; graph; isotonic point.', traps: 'Using final mass rather than change; uncontrolled tissue dimensions; confusing osmosis with diffusion.' },
          { id: 'rp4', number: 4, title: 'Food Tests', purpose: 'Use qualitative reagents for sugars, starch and protein; know lipid testing in normal course context.', mathsLink: 'Qualitative observations; controls; safe heating.', traps: 'Naming reagent without expected observation; mixing up Benedict\'s and Biuret.' },
          { id: 'rp5', number: 5, title: 'Amylase and pH', purpose: 'Investigate effect of pH on rate of amylase digestion using continuous sampling.', mathsLink: 'Rate = 1/time; control temperature; endpoint judgement.', traps: 'Treating time as rate; failing to control temperature; vague "enzyme works better".' },
          { id: 'rp6', number: 6, title: 'Photosynthesis', purpose: 'Investigate effect of light intensity on rate of photosynthesis.', mathsLink: 'Rate; inverse-square reasoning at HT; repeats; graph.', traps: 'Counting bubbles as volume without qualification; changing distance but not thinking about actual light intensity.' },
          { id: 'rp7', number: 7, title: 'Reaction Time', purpose: 'Plan and investigate effect of a factor on human reaction time.', mathsLink: 'Means; ethical/safety considerations; control variables.', traps: 'Practice effect; inconsistent release point; too few repeats.' },
          { id: 'rp8', number: 8, title: 'Plant Responses', biologyOnly: true, purpose: 'Investigate effect of light or gravity on growth of newly germinated seedlings; include measurements and drawings.', mathsLink: 'Length change; orientation; controls; labelled biological drawings.', traps: 'Confounding light and gravity; not using a control orientation.' },
          { id: 'rp9', number: 9, title: 'Ecology', purpose: 'Measure population size and use sampling to investigate distribution against an environmental factor.', mathsLink: 'Quadrats; transects; means; estimation; random/systematic sampling.', traps: 'Biased placement; inadequate sample size; claiming causation from correlation.' },
          { id: 'rp10', number: 10, title: 'Decay', biologyOnly: true, purpose: 'Investigate effect of temperature on rate of decay of fresh milk using pH change.', mathsLink: 'Rate; pH; temperature control; microorganisms.', traps: 'Assuming pH itself is rate; inconsistent starting conditions; weak safety reasoning.' }
        ]
      },
      {
        id: 'experimental-design-clinic',
        title: 'Experimental Design Clinic',
        type: 'design-clinic',
        intro: 'A strong tutor must be able to repair a weak investigation quickly and explain the reason for every change.',
        terms: [
          { term: 'Independent variable', def: 'The factor deliberately changed.' },
          { term: 'Dependent variable', def: 'The response measured.' },
          { term: 'Control variable', def: 'A factor kept sufficiently constant so the comparison is interpretable.' },
          { term: 'Control setup', def: 'A comparison condition used to show whether the independent variable is responsible for an effect.' },
          { term: 'Repeat', def: 'A repeated measurement/observation within the investigation.' },
          { term: 'Range', def: 'Spread of independent-variable values selected.' },
          { term: 'Interval', def: 'Difference between neighbouring values.' },
          { term: 'Sample size', def: 'Number of independent observational units/organisms/areas measured.' }
        ],
        repairs: [
          { id: 'repair1', text: 'A student tests pH on amylase but uses room-temperature solutions one day and refrigerated solutions the next.' },
          { id: 'repair2', text: 'A student compares two fertilisers using one plant per fertiliser.' },
          { id: 'repair3', text: 'A student places quadrats only where daisies are visible.' },
          { id: 'repair4', text: 'A student tests photosynthesis at 10, 20 and 30cm but changes lamp type between trials.' },
          { id: 'repair5', text: 'A student measures reaction time once before caffeine and once after caffeine.' }
        ]
      },
      {
        id: 'evaluation-language',
        title: 'Evaluation Language That Means Something',
        type: 'evaluation-language',
        intro: 'Avoid empty evaluation phrases such as "human error" or "make it more accurate". Require a mechanism.',
        pairs: [
          { weak: 'Repeat it', strong: 'Repeat measurements, identify anomalies and calculate a mean to reduce the influence of random variation.' },
          { weak: 'Use better equipment', strong: 'Use equipment with finer resolution if the measurement uncertainty is large relative to the change being measured.' },
          { weak: 'Control temperature', strong: 'Use a thermostatically controlled water bath because enzyme activity changes with temperature.' },
          { weak: 'Use more samples', strong: 'Increase sample size to make the estimate less vulnerable to unusual individuals/locations.' },
          { weak: 'It is not valid', strong: 'Name the uncontrolled/confounding variable and explain how it prevents attributing the outcome to the intended independent variable.' }
        ],
        task: 'Rewrite five vague evaluation comments from your own teaching into causal, examination-worthy statements.'
      },
      {
        id: 'measurement-concepts',
        title: 'Accuracy, Precision, Repeatability, Reproducibility & Uncertainty',
        type: 'measurement-concepts',
        intro: 'These terms should be used deliberately. Do not allow students to use them as interchangeable compliments.',
        concepts: [
          { idea: 'Accuracy', def: 'How close a result is to the true/accepted value where that is knowable.' },
          { idea: 'Precision', def: 'How closely repeated measurements agree / the fineness with which values are reported, depending on context.' },
          { idea: 'Repeatability', def: 'Same person/method/equipment obtains similar results.' },
          { idea: 'Reproducibility', def: 'Different person/method/equipment obtains similar results.' },
          { idea: 'Resolution', def: 'Smallest change an instrument can meaningfully distinguish.' },
          { idea: 'Uncertainty', def: 'Quantified doubt associated with a measurement; must be interpreted relative to scale where appropriate.' }
        ],
        vivaPrompts: [
          'Can a set of results be precise but inaccurate? Give a biological example.',
          'Why does repeating measurements not automatically remove a systematic error?',
          'When is a larger sample size more useful than simply measuring more precisely?',
          'Why is "percentage uncertainty" often more informative than absolute uncertainty when comparing measurements of different sizes?'
        ]
      },
      {
        id: 'maths-mastery-map',
        title: 'Mathematical Biology Mastery Map',
        type: 'maths-map',
        intro: 'AQA requires mathematical skills appropriate to Biology across arithmetic/numerical computation, data handling, algebra, graphs and geometry. Foundation and Higher papers differ in demand, but the tutor must be fluent across the whole GCSE requirement.',
        principle: 'Never assume a "maths error" is purely mathematical. The student may know the calculation but misunderstand what quantity the Biology requires. Diagnose both layers.',
        domains: [
          { domain: 'Number', teach: 'Decimals, standard form, estimation, order of magnitude' },
          { domain: 'Ratio & percentage', teach: 'Ratios, fractions, percentage change, percentage gain/loss' },
          { domain: 'Data', teach: 'Means, median/mode, frequency displays, histograms, sampling, probability, correlation' },
          { domain: 'Algebra', teach: 'Simple equations; symbols/relationships; rearrangement where needed' },
          { domain: 'Graphs', teach: 'Plotting, scales, interpolation, slope/gradient, intercept, linear relationships' },
          { domain: 'Geometry', teach: 'Area, surface area, volume, πr² in biological contexts' },
          { domain: 'Rates', teach: 'Change/time; reciprocal time where appropriate' },
          { domain: 'Magnification', teach: 'image size = magnification × actual size; unit conversion' }
        ]
      },
      {
        id: 'maths-labs',
        title: 'Mathematical Biology Laboratories A-D',
        type: 'maths-labs',
        labs: [
          { key: 'A', title: 'Magnification, Units and Scale', questions: [
            { id: 'ma1', text: 'A cell image is 48mm long. The actual cell length is 80µm. Calculate the magnification.' },
            { id: 'ma2', text: 'A microscope image has magnification ×400. A structure measures 36mm on the image. Calculate actual size in µm.' },
            { id: 'ma3', text: 'Convert 0.075mm to µm.' },
            { id: 'ma4', text: 'A scale bar labelled 20µm measures 8mm on a printed image. A cell measures 30mm. Estimate its actual length.' },
            { id: 'ma5', text: 'Explain two common reasons students lose marks on magnification questions even when they know the equation.' }
          ]},
          { key: 'B', title: 'Percentage Change, Ratios and Rates', questions: [
            { id: 'mb1', text: 'Potato cylinder mass changes from 4.80g to 4.32g. Calculate percentage change and retain the sign.' },
            { id: 'mb2', text: 'A leaf produces 18 bubbles in 3 minutes. Calculate bubbles per minute.' },
            { id: 'mb3', text: 'A starch digestion takes 75s. Calculate 1/time as a rate proxy to three significant figures.' },
            { id: 'mb4', text: 'Red:white flowers occur in a 3:1 ratio. Predict numbers in a sample of 240.' },
            { id: 'mb5', text: 'A population estimate increases from 320 to 416. Calculate percentage increase.' },
            { id: 'mb6', text: 'Explain when a ratio is more useful than an absolute difference in Biology.' }
          ]},
          { key: 'C', title: 'Means, Sampling and Probability', questions: [
            { id: 'mc1', text: 'Quadrats contain 4, 7, 0, 5, 9 and 5 daisies. Calculate the mean number per quadrat.' },
            { id: 'mc2', text: 'A habitat is 120m². Each quadrat is 0.50m². The mean count is 6 plants per quadrat. Estimate the population.' },
            { id: 'mc3', text: 'Explain why random quadrat placement matters.' },
            { id: 'mc4', text: 'Explain why a larger sample may improve confidence without guaranteeing accuracy.' },
            { id: 'mc5', text: 'A heterozygous cross is Aa × Aa. State the probability of aa and explain the difference between expected probability and an actual small family outcome.' }
          ]},
          { key: 'D', title: 'Graphs and Gradients', questions: [
            { id: 'md1', text: 'Light intensity vs oxygen production over 10 minutes — specify graph, axes, units, treatment of repeats, and what the gradient/pattern would mean biologically.' },
            { id: 'md2', text: 'Sucrose concentration vs percentage change in potato mass — same requirements.' },
            { id: 'md3', text: 'Distance along a transect vs abundance of a plant species — same requirements.' },
            { id: 'md4', text: 'Temperature vs milk pH after a fixed period — same requirements.' },
            { id: 'md5', text: 'Time vs blood glucose concentration after a meal — same requirements.' },
            { id: 'md6', text: 'Gradient drill: a graph rises from 2.0 units at 10s to 8.0 units at 40s. Calculate the mean gradient between the two points, show units, then state what the gradient means in context.' }
          ]}
        ]
      },
      {
        id: 'data-interpretation-school',
        title: 'Data Interpretation School',
        type: 'data-interp',
        intro: 'Coach students to separate what the data show from why the pattern may occur. The Three Sentences: 1) Pattern — what changes? 2) Evidence — quote/select data. 3) Biology — explain mechanism only if the question asks for it.',
        table: { headers: ['Temperature (°C)', 'Mean reaction rate (arbitrary units)', 'Range'], rows: [['10','1.8','1.5-2.1'],['20','3.7','3.4-4.0'],['30','6.2','5.7-6.8'],['40','5.1','4.2-6.0'],['50','1.0','0.2-1.8']] },
        questions: [
          { id: 'di1', text: 'Describe the pattern using quantitative evidence.' },
          { id: 'di2', text: 'Suggest a biological explanation.' },
          { id: 'di3', text: 'At which temperatures is variability greatest?' },
          { id: 'di4', text: 'Can the data prove temperature is the only cause of the pattern? Explain.' },
          { id: 'di5', text: 'Write one misleading conclusion a student might make and correct it.' }
        ]
      },
      {
        id: 'correlation-causation',
        title: 'Correlation, Causation and Biological Claims',
        type: 'claim-audit',
        intro: 'Students often overclaim. Actively police the difference between association and causation.',
        claims: [
          { id: 'claim1', text: 'Areas with more foxes have fewer rabbits, so foxes caused the rabbit decline.' },
          { id: 'claim2', text: 'Plants near a road are shorter, proving pollution inhibits growth.' },
          { id: 'claim3', text: 'People who exercise more have lower resting heart rates, so exercise is the only explanation.' },
          { id: 'claim4', text: 'A larger inhibition zone proves the antibiotic will be most effective in a patient.' }
        ]
      },
      {
        id: 'practical-transfer-assessment',
        title: 'Practical Transfer Assessment',
        type: 'formal-assessment',
        instructions: '30 marks, unfamiliar contexts, no notes. Suggested time: 40 minutes.',
        sections: [{ heading: 'Practical Transfer Assessment', questions: [
          { id: 'pt1', marks: 4, text: 'A student investigates how salt concentration affects water uptake by radish seedlings. Identify the independent variable, dependent variable and two controls.' },
          { id: 'pt2', marks: 3, text: 'Explain why percentage change may be preferable to absolute mass change when samples begin at different masses.' },
          { id: 'pt3', marks: 3, text: 'A student records 2, 3, 3, 14 and 4. Explain how the student should treat these results before calculating a representative value.' },
          { id: 'pt4', marks: 3, text: 'A bacterial-clear-zone investigation produces diameters. Explain why area may give a more meaningful comparison and give the equation required.' },
          { id: 'pt5', marks: 4, text: 'A photosynthesis experiment uses lamp distance as a proxy for light intensity. Give two limitations and one improvement.' },
          { id: 'pt6', marks: 5, text: 'A field study finds a correlation between soil moisture and moss abundance. Evaluate the claim that moisture caused the distribution.' },
          { id: 'pt7', marks: 8, text: 'Design a short investigation to test whether temperature affects the time taken for an enzyme-controlled colour change. Include repeatability and safety.' }
        ]}]
      },
      {
        id: 'clearance-microteaching',
        title: 'Tutor Microteaching Assessment',
        type: 'clearance-microteaching',
        intro: 'Deliver a 20-minute online tutoring segment. Your assessor selects one of the prompts below immediately before preparation.',
        promptOptions: [
          'Teach a Year 10 Higher student how to reason through an osmosis practical question rather than memorise the method.',
          'Teach a Foundation student percentage change using a plant-tissue practical.',
          'Coach a Grade 8/9 student through an unfamiliar ecology sampling/evaluation question.',
          'Diagnose and repair errors in a magnification calculation.'
        ],
        architecture: 'RETRIEVE → DIAGNOSE → MODEL → GUIDED PRACTICE → INDEPENDENT CHECK → FEEDBACK → PRESCRIBE',
        observationDomains: ['Scientific/practical accuracy', 'Mathematical explanation', 'Diagnostic questioning', 'Exam transfer', 'Student thinking']
      },
      {
        id: 'formal-clearance-exam',
        title: 'Formal GCSE Clearance Examination',
        type: 'formal-assessment',
        instructions: 'Suggested time: 90 minutes. Total: 80 marks. This is an original Inspire assessment administered under controlled conditions.',
        sections: [
          { heading: 'Section A — Practical Biology [30]', questions: [
            { id: 'ce1', marks: 3, text: 'Explain why a coverslip and a thin specimen improve light-microscope observation.' },
            { id: 'ce2', marks: 3, text: 'In an osmosis investigation, explain why percentage mass change is plotted rather than final mass.' },
            { id: 'ce3', marks: 4, text: 'Explain two controls needed when comparing antiseptics using bacterial cultures.' },
            { id: 'ce4', marks: 4, text: 'A student says "repeat three times makes the experiment valid." Evaluate this statement.' },
            { id: 'ce5', marks: 6, text: 'Describe how quadrats and a transect can be used together to investigate distribution along an environmental gradient.' },
            { id: 'ce6', marks: 4, text: 'Evaluate a method that tests enzyme activity at different pH values but does not control temperature.' },
            { id: 'ce7', marks: 3, text: 'Suggest why a reaction-time investigation could show improvement even when the tested factor has no effect.' },
            { id: 'ce8', marks: 3, text: 'Explain why a negative result in a food test needs an appropriate control/known comparison when reliability is uncertain.' }
          ]},
          { heading: 'Section B — Mathematical Biology [25]', questions: [
            { id: 'ce9', marks: 3, text: 'A cell image is 72mm; actual cell size is 120µm. Calculate magnification.' },
            { id: 'ce10', marks: 3, text: 'Mass changes from 5.20g to 5.72g. Calculate percentage change.' },
            { id: 'ce11', marks: 4, text: 'Five counts are 8, 10, 9, 11, 42. Calculate the mean and explain whether you would use it without comment.' },
            { id: 'ce12', marks: 3, text: 'A quadrat of 0.25m² contains a mean of 5 plants. Estimate the population in 80m².' },
            { id: 'ce13', marks: 3, text: 'Rate changes from 1.5 to 4.5 units over 60s. Calculate gradient with units.' },
            { id: 'ce14', marks: 4, text: 'A structure is 0.0045mm. Express in µm and standard form in metres.' },
            { id: 'ce15', marks: 2, text: 'Explain why using more significant figures than measurement resolution supports is misleading.' },
            { id: 'ce16', marks: 3, text: 'State one biological context where an inverse relationship may arise and explain it.' }
          ]},
          { heading: 'Section C — Data, Evaluation and Tutor Judgement [25]', questions: [
            { id: 'ce17', marks: 4, text: 'Distinguish repeatability from reproducibility using a Biology example.' },
            { id: 'ce18', marks: 4, text: 'Explain why correlation between two ecological variables does not by itself establish causation.' },
            { id: 'ce19', marks: 5, text: 'A student repeatedly writes "human error". Give a 3-step coaching intervention to improve evaluation answers.' },
            { id: 'ce20', marks: 4, text: 'A Higher student calculates correctly but omits units and does not interpret the answer. Diagnose the error category and state how you would retrain it.' },
            { id: 'ce21', marks: 8, text: 'Design a 10-minute diagnostic sequence to decide whether a student\'s poor graph question performance is due to Biology, maths or question interpretation.' }
          ]}
        ]
      },
      {
        id: 'clearance-board-info',
        title: 'GCSE Clearance Board',
        type: 'clearance-board',
        gates: [
          { gate: 'GCSE Biology written exam', standard: '≥85%', compensable: 'No' },
          { gate: 'Specification boundary control', standard: '≥90%', compensable: 'No' },
          { gate: 'Practical transfer assessment', standard: '≥85%', compensable: 'No' },
          { gate: 'Marking calibration', standard: '≥90% agreement', compensable: 'No' },
          { gate: 'Observed Foundation/Higher teaching', standard: '≥4/5', compensable: 'No' },
          { gate: 'Scientific accuracy', standard: 'PASS / ≥4/5', compensable: 'No' },
          { gate: 'Safeguarding/professional practice', standard: 'PASS', compensable: 'No' },
          { gate: 'Overall portfolio', standard: 'Complete + satisfactory', compensable: 'Yes, minor gaps only' }
        ],
        decisions: [
          'CLEAR — GCSE PROVISIONALLY CLEARED: may take approved GCSE students under supported-practice QA.',
          'CLEAR WITH CONDITIONS: may teach specified student profiles/topics while completing named remediation within a fixed review period.',
          'REMEDIATE AND REASSESS: not yet independently deployable; targeted retraining required.',
          'DO NOT CLEAR: serious scientific, safeguarding or professional-practice concern.'
        ],
        nonNegotiable: 'No aggregate score can compensate for unsafe practice or materially inaccurate Biology. This decision is always made by a human assessor, never generated automatically from a completion percentage.'
      },
      {
        id: 'deployment-charter',
        title: 'Candidate GCSE Deployment Charter',
        type: 'deployment-charter',
        intro: 'If cleared, you enter supported practice. Clearance is an Inspire internal quality designation; it does not confer Qualified Teacher Status in England or replace any legal employment, safeguarding, identity, qualification or background-check requirements.',
        commitments: [
          'Plan from the relevant specification and student tier/route.',
          'Use diagnostic evidence before prescribing teaching.',
          'Teach practical and mathematical reasoning, not shortcuts alone.',
          'Record learning needs, progress and agreed next steps.',
          'Escalate safeguarding or professional concerns immediately through Inspire procedures.',
          'Submit to scheduled QA, lesson observation and assessment review.',
          'Avoid teaching beyond the specification when it obscures what the student actually needs.',
          'Maintain scientific accuracy and correct mistakes transparently if they occur.'
        ],
        standard: 'A cleared tutor should leave a student not only knowing more Biology, but reasoning more scientifically, answering more precisely, and understanding exactly what to do next.'
      }
    ]
  }
}

if (typeof window !== 'undefined') window.TutorAcademyContent = TUTOR_ACADEMY_BIOLOGY
if (typeof module !== 'undefined' && module.exports) module.exports = TUTOR_ACADEMY_BIOLOGY
