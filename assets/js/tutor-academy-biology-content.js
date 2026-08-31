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
  'biology-gcse-stage-3': { comingSoon: true, title: 'Examiner School', note: 'Stage 3 content is being built from Pack 03.' },
  'biology-gcse-stage-4': { comingSoon: true, title: 'Practical & Mathematical Biology', note: 'Stage 4 content is being built from Pack 04.' }
}

if (typeof window !== 'undefined') window.TutorAcademyContent = TUTOR_ACADEMY_BIOLOGY
if (typeof module !== 'undefined' && module.exports) module.exports = TUTOR_ACADEMY_BIOLOGY
