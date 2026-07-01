const project1Sections = [
  {
    id: 'section1',
    title: 'Section 1: Scientific Questions',
    subtitle: 'What makes a question scientific? Learn to identify and create testable questions.',
    fields: [
      {
        type: 'checkbox-group',
        label: 'Activity 1.1 — Question Sorting (tick the scientific questions)',
        name: 'question_sorting',
        options: [
          'Does a plant grow taller in sunlight?',
          'What is the best football team?',
          'Does sugar dissolve faster in hot water?',
          'Why do people like music?'
        ]
      },
      {
        type: 'textarea',
        label: 'Activity 1.2 — Rewrite this question to make it scientific: "Which shoes are better?"',
        name: 'scientific_question_1',
        placeholder: 'Example: Which shoes have better grip on wet surfaces?'
      },
      {
        type: 'textarea',
        label: 'Rewrite this question to make it scientific: "Which paper plane is best?"',
        name: 'scientific_question_2',
        placeholder: 'Your scientific question...'
      },
      {
        type: 'textarea',
        label: 'Reflection: Why do scientists need questions that can be tested?',
        name: 'reflection_testing',
        placeholder: 'Write your reflection here... (200 words max)',
        maxlength: 1000
      },
      {
        type: 'photo-upload',
        label: 'Upload photos (optional)',
        name: 'section1_photos',
        section: 'section1'
      }
    ]
  },
  {
    id: 'section2',
    title: 'Section 2: Variables & Fair Testing',
    subtitle: 'In science, we change one thing at a time. Learn about independent, dependent, and control variables.',
    fields: [
      {
        type: 'text',
        label: 'Question: Does the height a ball is dropped from affect how high it bounces? — Independent variable (what you change)',
        name: 'independent_var',
        placeholder: 'Height the ball is dropped from'
      },
      {
        type: 'text',
        label: 'Dependent variable (what you measure)',
        name: 'dependent_var',
        placeholder: 'How high the ball bounces'
      },
      {
        type: 'text',
        label: 'One control variable (what you keep the same)',
        name: 'control_var',
        placeholder: 'Same ball, same surface, etc.'
      },
      {
        type: 'textarea',
        label: 'Is This Fair? A pupil tests how far a toy car rolls but uses different cars and changes the ramp height each time. Is this a fair test? Why or why not?',
        name: 'fair_test_evaluation',
        placeholder: 'Your answer...'
      },
      {
        type: 'photo-upload',
        label: 'Upload photos of your setup (optional)',
        name: 'section2_photos',
        section: 'section2'
      }
    ]
  },
  {
    id: 'section3',
    title: 'Section 3: Planning Your Investigation',
    subtitle: 'Now you will plan your own scientific investigation.',
    fields: [
      {
        type: 'text',
        label: 'Investigation Title',
        name: 'investigation_title',
        placeholder: 'Example: How ramp length affects toy car distance'
      },
      {
        type: 'textarea',
        label: 'Aim (What are you trying to find out?)',
        name: 'aim',
        placeholder: 'I am trying to find out...'
      },
      {
        type: 'text',
        label: 'Independent Variable',
        name: 'plan_independent_var',
        placeholder: 'What will you change?'
      },
      {
        type: 'text',
        label: 'Dependent Variable',
        name: 'plan_dependent_var',
        placeholder: 'What will you measure?'
      },
      {
        type: 'text',
        label: 'Control Variables',
        name: 'plan_control_vars',
        placeholder: 'What will you keep the same?'
      },
      {
        type: 'textarea',
        label: 'Prediction (Your hypothesis) — I predict that...',
        name: 'prediction',
        placeholder: 'I predict that...'
      },
      {
        type: 'textarea',
        label: 'Method (Number your steps clearly)',
        name: 'method',
        placeholder: '1. Stack books to make a ramp\n2. Place the ramp at 30cm\n3. ...',
        rows: 10
      },
      {
        type: 'textarea',
        label: 'Equipment Needed',
        name: 'equipment',
        placeholder: 'List all equipment needed...'
      },
      {
        type: 'photo-upload',
        label: 'Upload photos of your planning (optional)',
        name: 'section3_photos',
        section: 'section3'
      }
    ]
  },
  {
    id: 'section4',
    title: 'Section 4: Results & Data',
    subtitle: 'Record your measurements and calculate averages.',
    fields: [
      {
        type: 'table',
        label: 'Results Table',
        name: 'results_table',
        columns: ['Ramp Length (cm)', 'Trial 1 (cm)', 'Trial 2 (cm)', 'Average (cm)'],
        rows: [
          ['30', '', '', ''],
          ['60', '', '', ''],
          ['90', '', '', '']
        ]
      },
      {
        type: 'textarea',
        label: 'Reflection: Why do scientists repeat measurements?',
        name: 'repeat_reflection',
        placeholder: 'Scientists repeat measurements because...'
      },
      {
        type: 'photo-upload',
        label: 'Upload photos of your experiment in action',
        name: 'section4_photos',
        section: 'section4'
      }
    ]
  },
  {
    id: 'section5',
    title: 'Section 5: Drawing a Graph',
    subtitle: 'Create a graph to visualize your results.',
    fields: [
      {
        type: 'checkbox-group',
        label: 'Graph Checklist (check all that apply)',
        name: 'graph_checklist',
        options: [
          'Title included',
          'Labelled axes',
          'Correct units',
          'Sensible scale'
        ]
      },
      {
        type: 'photo-upload',
        label: 'Upload your graph (hand-drawn or computer-generated)',
        name: 'section5_photos',
        section: 'section5',
        required: true
      },
      {
        type: 'textarea',
        label: 'Describe your graph (optional)',
        name: 'graph_description',
        placeholder: 'What pattern does your graph show?'
      }
    ]
  },
  {
    id: 'section6',
    title: 'Section 6: Conclusion',
    subtitle: 'A conclusion answers the question using evidence.',
    fields: [
      {
        type: 'textarea',
        label: 'My Conclusion (use sentence starters if helpful: "The results show that...", "As the independent variable increased...", "This means that...")',
        name: 'conclusion',
        placeholder: 'The results show that...',
        rows: 8
      },
      {
        type: 'photo-upload',
        label: 'Upload any additional observations (optional)',
        name: 'section6_photos',
        section: 'section6'
      }
    ]
  },
  {
    id: 'section7',
    title: 'Section 7: Evaluation & Improvement',
    subtitle: 'Scientists always think about how their investigation could be better.',
    fields: [
      {
        type: 'textarea',
        label: 'What Worked Well?',
        name: 'worked_well',
        placeholder: 'Write about what went well in your investigation...'
      },
      {
        type: 'textarea',
        label: 'What Could Be Improved?',
        name: 'improvements',
        placeholder: 'What could have been done better?'
      },
      {
        type: 'textarea',
        label: 'One Improvement I Would Make Next Time',
        name: 'next_time',
        placeholder: 'Next time I would...'
      },
      {
        type: 'photo-upload',
        label: 'Upload your favorite photos from this project',
        name: 'section7_photos',
        section: 'section7'
      }
    ]
  },
  {
    id: 'section8',
    title: 'Final Reflection',
    subtitle: 'Complete your journey as a science investigator.',
    fields: [
      {
        type: 'textarea',
        label: 'I learned that science is about...',
        name: 'final_learning',
        placeholder: 'I learned that science is about...'
      },
      {
        type: 'textarea',
        label: 'I can now explain what a fair test is because...',
        name: 'fair_test_explanation',
        placeholder: 'I can now explain...'
      },
      {
        type: 'textarea',
        label: 'One thing I am proud of in this project is...',
        name: 'proud_of',
        placeholder: 'One thing I am proud of...'
      }
    ]
  }
];

const project2Sections = [
  {
    id: 's1',
    title: 'Section 1: MATTER & PARTICLES',
    subtitle: 'What Is Matter?',
    fields: [
      {
        type: 'textarea',
        label: 'Activity 1.1 Matter Hunt\nLook around you. List five things made of matter.',
        placeholder: ''
      },
      {
        type: 'drawing',
        label: 'Activity 1.2 Particle Diagrams\nDraw how you think particles are arranged in each state of matter. Use Fig. 2 and Fig. 3 above to guide you.',
        columns: ['SOLID', 'LIQUID', 'GAS']
      },
      {
        type: 'textarea',
        label: 'Reflection\nWhy do solids keep their shape but liquids and gases do not? Use particle theory in your answer.',
        placeholder: ''
      }
    ]
  },
  {
    id: 's2',
    title: 'Section 2: MIXTURES & SEPARATION',
    subtitle: 'What Is a Mixture?',
    fields: [
      {
        type: 'table',
        label: 'Activity 2.1 Soluble or Insoluble?\nPredict whether each substance will dissolve in water. Tick your answer.',
        columns: ['Substance', 'Soluble?', 'Insoluble?'],
        rows: ['Sugar', 'Sand', 'Salt', 'Flour']
      },
      {
        type: 'table',
        label: 'INVESTIGATION 2 — The Dissolving Race\nVariables',
        columns: ['Variable Type', 'Your Answer'],
        rows: [
          'Independent variable (what I will change)',
          'Dependent variable (what I will measure)',
          'Control variables (what I will keep the same)'
        ]
      },
      {
        type: 'textarea',
        label: 'My Prediction\nI predict that:',
        placeholder: ''
      },
      {
        type: 'table',
        label: 'Activity 2.2 Which Separation Method?\nFor each mixture below, choose the best separation method and give your reason.',
        columns: ['Mixture', 'Best Separation Method', 'Reason'],
        rows: [
          'Sand and water',
          'Salt water (to recover salt)',
          'Pure water from salt water',
          'Iron filings and sand',
          'Different coloured inks',
          'Gravel and sand'
        ]
      }
    ]
  },
  {
    id: 's3',
    title: 'Section 3: PHYSICAL & CHEMICAL CHANGE',
    subtitle: 'Not all changes are the same. Some can be reversed; others cannot. The key question is: has a new substance been formed?',
    fields: [
      {
        type: 'table',
        label: 'Activity 3.1 Physical or Chemical?\nRead each change below. Decide if it is physical or chemical, and explain how you know.',
        columns: ['Change', 'Physical or Chemical?', 'How Do You Know?'],
        rows: [
          'Ice melting into water',
          'Burning wood',
          'Dissolving salt in water',
          'Baking a cake',
          'Tearing paper',
          'Rusting iron nail'
        ]
      },
      {
        type: 'textarea',
        label: 'INVESTIGATION 4 — Fizz, Foam & Gas\nMy Prediction\nWhat do you think will happen when the substances are mixed?',
        placeholder: ''
      },
      {
        type: 'table',
        label: 'Observation Table',
        columns: ['Time', 'What I Saw', 'What I Heard', 'Other Observations'],
        rows: ['At the start', 'During the reaction', 'After the reaction']
      },
      {
        type: 'checkbox-group',
        label: 'Signs of Chemical Change — Tick what you observed',
        options: [
          'Bubbles forming',
          'Foam produced',
          'Gas released',
          'Temperature change (feel the container)',
          'New smell (different from vinegar alone)',
          'Colour change (if food colouring used)'
        ]
      },
      {
        type: 'textarea',
        label: 'Conclusion Questions\n1. What evidence suggested a chemical reaction happened? List at least two observations.',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '2. The gas produced is carbon dioxide (CO₂). How does the washing-up liquid make the CO₂ visible?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '3. Was this a physical or chemical change? Justify your answer with evidence from your observations.',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Evaluation\nWhat worked well in this investigation?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'What could be improved?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'How could the investigation be made more reliable (i.e. give more trustworthy results)?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '★ EXTENSION: The Kitchen Volcano\nHow could you make the reaction more dramatic, or change its rate? Change one variable at a time and predict what will happen.',
        placeholder: 'Try: more bicarbonate of soda / warm vinegar instead of cold / a narrower container / different types of acid (lemon juice instead of vinegar).'
      },
      {
        type: 'textarea',
        label: 'Extension Challenge — Think Like a Chemist\nWhat do you think would happen if:\n• More bicarbonate of soda was added?\n• Warm vinegar was used instead of cold?\n• The container was sealed tightly after mixing?',
        placeholder: ''
      },
      {
        type: 'photo-upload',
        label: 'Upload a photo of your Fizz & Foam investigation (optional)',
        name: 'p2_section3_photos',
        section: 'p2_section3'
      }
    ]
  },
  {
    id: 's4',
    title: 'Section 4: KITCHEN ACIDS & ALKALIS',
    subtitle: 'What Are Acids and Alkalis?',
    fields: [
      {
        type: 'table',
        label: 'Activity 4.1 Kitchen pH Detective — Predictions\nBefore carrying out Investigation 4, predict whether each substance is acidic, alkaline, or neutral.',
        columns: ['Kitchen Substance', 'My Prediction (Acid / Alkali / Neutral)', 'Actual Result'],
        rows: [
          'Lemon juice',
          'Soap',
          'Tap water',
          'Vinegar',
          'Bicarbonate of soda solution',
          'Orange juice'
        ]
      },
      {
        type: 'table',
        label: 'Results Table',
        columns: ['Substance', 'Colour with Indicator', 'Acid, Alkali, or Neutral?', 'Estimated pH'],
        rows: [
          'Vinegar',
          'Lemon juice',
          'Bicarbonate of soda solution',
          'Soap solution',
          'Tap water',
          'Orange juice'
        ]
      },
      {
        type: 'textarea',
        label: 'Conclusion\nWhich of the kitchen substances tested were acids?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Which were alkalis?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Did any result surprise you? Explain why, using your knowledge of acids and alkalis.',
        placeholder: ''
      }
    ]
  },
  {
    id: 's5',
    title: 'Section 5: CHEMISTRY VOCABULARY',
    subtitle: 'Learning precise scientific vocabulary is essential for communicating clearly in science.',
    fields: [
      { type: 'text', label: 'Matter', placeholder: '' },
      { type: 'text', label: 'Particle', placeholder: '' },
      { type: 'text', label: 'Solid', placeholder: '' },
      { type: 'text', label: 'Liquid', placeholder: '' },
      { type: 'text', label: 'Gas', placeholder: '' },
      { type: 'text', label: 'Mixture', placeholder: '' },
      { type: 'text', label: 'Dissolve', placeholder: '' },
      { type: 'text', label: 'Soluble', placeholder: '' },
      { type: 'text', label: 'Insoluble', placeholder: '' },
      { type: 'text', label: 'Solution', placeholder: '' },
      { type: 'text', label: 'Solute', placeholder: '' },
      { type: 'text', label: 'Solvent', placeholder: '' },
      { type: 'text', label: 'Evaporation', placeholder: '' },
      { type: 'text', label: 'Filtration', placeholder: '' },
      { type: 'text', label: 'Chromatography', placeholder: '' },
      { type: 'text', label: 'Distillation', placeholder: '' },
      { type: 'text', label: 'Physical change', placeholder: '' },
      { type: 'text', label: 'Chemical change', placeholder: '' },
      { type: 'text', label: 'Reactant', placeholder: '' },
      { type: 'text', label: 'Product', placeholder: '' },
      { type: 'text', label: 'Acid', placeholder: '' },
      { type: 'text', label: 'Alkali', placeholder: '' },
      { type: 'text', label: 'Neutral', placeholder: '' },
      { type: 'text', label: 'pH', placeholder: '' },
      { type: 'text', label: 'Indicator', placeholder: '' },
      { type: 'text', label: 'Neutralisation', placeholder: '' },
      { type: 'text', label: 'Reversible', placeholder: '' },
      { type: 'text', label: 'Irreversible', placeholder: '' }
    ]
  },
  {
    id: 's6',
    title: 'Section 6: PREPARING FOR YEAR 7',
    subtitle: 'What to Expect in Secondary School Science',
    fields: [
      {
        type: 'checkbox-group',
        label: 'Safety in the Laboratory',
        options: [
          'Wear safety goggles when instructed',
          'Tie long hair back',
          'Never eat or drink in the laboratory',
          'Follow all instructions carefully',
          'Tell your teacher immediately if something spills or breaks',
          'Wash your hands after practical work'
        ]
      }
    ]
  },
  {
    id: 's7',
    title: 'Final Reflection: BECOMING A CHEMIST',
    subtitle: 'Complete the sentences below:',
    fields: [
      {
        type: 'textarea',
        label: 'I learned that matter is made of',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'I can now explain the difference between a physical and chemical change because',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'One thing I found surprising about chemistry was',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'One separation method I would like to try again is',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'One thing I am proud of in this project is',
        placeholder: ''
      },
      {
        type: 'checkbox-group',
        label: 'What Have I Achieved?\nA checklist:',
        options: [
          'I can explain particle theory',
          'I can describe solids, liquids and gases',
          'I can explain dissolving',
          'I can choose a separation method',
          'I can identify chemical change',
          'I can explain acids and alkalis',
          'I can plan a fair investigation',
          'I am ready for Year 7 Chemistry'
        ]
      }
    ]
  },
  {
    id: 's8',
    title: 'Appendix: KITCHEN CHEMISTRY INVESTIGATIONS',
    subtitle: 'Kitchen Chemistry Investigations',
    fields: [
      {
        type: 'checkbox-group',
        label: '⚠ SAFETY GUIDELINES — ALWAYS FOLLOW THESE RULES',
        options: [
          'Always work with an adult supervisor present',
          'Do NOT taste or eat anything used in investigations',
          'Clean all equipment thoroughly before and after use',
          'Wash hands thoroughly after all investigations',
          'Work on a clear, protected surface. Use a tray.',
          'Handle hot liquids with care. Use oven gloves and always wait for liquids to cool before handling.'
        ]
      },
      {
        type: 'drawing',
        label: 'INVESTIGATION 1 — Ice, Water, Steam\nObserve ice cubes carefully. Draw how you think the particles are arranged. (use the table below)',
        columns: ['SOLID (Ice)', 'LIQUID (Water)', 'GAS (Steam)']
      },
      {
        type: 'textarea',
        label: 'Watch ice melting. What do you think happens to the particles as they gain energy?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'With adult supervision, observe water boiling. What does steam tell you about particle movement?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Observe steam condensing on a cold surface. What does this tell you about particle energy?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Conclusion\nUse particle theory to explain what happens when ice melts and then the water boils:',
        placeholder: ''
      },
      {
        type: 'table',
        label: 'INVESTIGATION 2 — The Dissolving Race\nResults',
        columns: ['Substance', 'Time to Dissolve (seconds)', 'Observations'],
        rows: ['Sugar', 'Salt', 'Flour (control — insoluble)']
      },
      {
        type: 'textarea',
        label: 'Conclusion\nWhich substance dissolved fastest?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Why do you think this happened? Use particle theory in your answer.',
        placeholder: ''
      },
      {
        type: 'table',
        label: 'INVESTIGATION 3 — The Kitchen Separation Challenge\nPlanning\nPlan your sequence of steps carefully before you begin. Think: which substances can each method separate?',
        columns: ['Step', 'Method I Will Use', 'This Will Separate', 'Reason'],
        rows: ['Step 1', 'Step 2', 'Step 3', 'Step 4']
      },
      {
        type: 'textarea',
        label: 'Results and Reflection\nDid you successfully separate all four substances?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Which step was most difficult? Why?',
        placeholder: ''
      },
      {
        type: 'photo-upload',
        label: 'Upload a photo of your Kitchen Separation setup (optional)',
        name: 'p2_section8_photos',
        section: 'p2_section8'
      },
      {
        type: 'textarea',
        label: 'INVESTIGATION 4 — Fizz, Foam and Gas\nMy Prediction\nWhat do you think will happen when the vinegar and bicarbonate of soda are mixed? Write your prediction and give a reason.',
        placeholder: ''
      },
      {
        type: 'table',
        label: 'Observation Table',
        columns: ['Time', 'What I Saw', 'What I Heard', 'What I Felt (temperature)'],
        rows: ['At the start', 'During the reaction', 'After the reaction']
      },
      {
        type: 'checkbox-group',
        label: 'Signs of Chemical Change — Tick what you observed',
        options: [
          'Bubbles forming',
          'Foam produced',
          'Gas released (CO₂)',
          'Temperature change (container felt cooler)',
          'New smell (different from vinegar alone)',
          'Change in appearance of the mixture'
        ]
      },
      {
        type: 'textarea',
        label: 'Conclusion\n1. List two pieces of evidence from your observations that show a chemical reaction took place.',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '2. The gas produced in this reaction is carbon dioxide (CO₂). How does the washing-up liquid make this visible?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '3. This reaction felt slightly cooler than room temperature. What does this tell you about the energy involved?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '4. Was this a physical or chemical change? Give two reasons for your answer.',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'Evaluation\nWhat worked well in this investigation?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'What could be improved to make the results more reliable?',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: 'How could you change one variable to test a new question? Write a new investigation question you could explore.',
        placeholder: ''
      },
      {
        type: 'textarea',
        label: '★ Extension Challenge\nChange one variable at a time and predict what will happen:\nTry warm vinegar instead of cold. Does the reaction happen faster? Why?\nTry more bicarbonate of soda. Does more gas form?\nTry lemon juice instead of vinegar. Does an acid-alkali reaction still occur?\nRecord your prediction, carry out the test, and write what you found.',
        placeholder: ''
      }
    ]
  }
];

const projectSections = {
  1: project1Sections,
  4: project2Sections
};

const projectMeta = {
  1: {
    title: 'The Great Science Investigator',
    subtitle: 'Learning how science works',
    objectives: [
      'Ask scientific questions',
      'Plan and carry out a fair test',
      'Identify variables',
      'Record and analyse data',
      'Draw and interpret graphs',
      'Explain conclusions using evidence'
    ]
  },
  4: {
    title: 'Kitchen Chemistry: Matter, Mixtures & Change',
    subtitle: 'Exploring particles, materials, and how substances change',
    objectives: [
      'Explain what matter is made of using particle theory',
      'Describe the properties of solids, liquids, and gases',
      'Identify and separate mixtures using scientific methods',
      'Distinguish between physical and chemical changes',
      'Observe and record evidence of chemical reactions',
      'Use scientific vocabulary to explain what you observe'
    ]
  }
};