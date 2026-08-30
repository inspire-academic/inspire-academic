// curriculum-registry.js — Curriculum Library document registry (single
// source of truth), same pattern as spec-map.js / core-topics.js.
// window.CURRICULUM_REGISTRY -> [ { ...document metadata } ]
// Consumed by tools/curriculum.html, which never hardcodes a document —
// it only renders this array. To add a new curriculum document: drop
// the file under resources/curriculum/inspire/ or resources/curriculum/
// dfe/, then add one entry here. Full walkthrough:
// docs/reference/curriculum-library-howto.md
//
// Fields:
//   id         unique slug-safe string, used as the React/DOM key
//   slug       URL/search-friendly identifier (currently == id)
//   title      full document title shown on the card
//   description  1-2 sentence card description
//   category   'inspire-guide' | 'official-dfe'
//   yearGroup  e.g. 'Year 7' ... 'Year 11' | 'GCSE Readiness' | null (DfE has none)
//   keyStage   display label, e.g. 'Key Stage 3', 'Key Stage 4 / GCSE'
//   subject    always 'Maths & Science' today — kept as a field so a
//              future single-subject document doesn't need a reshape
//   publisher  'Inspire Academic' | 'Department for Education'
//   official   true for statutory DfE documents, false for Inspire guides
//   reference  DfE publication reference (e.g. 'DFE-00179-2013') or null
//   pdfUrl     public URL to the PDF (always present)
//   wordUrl    public URL to the .docx, or null if none exists
//   order      sort position within its category
//   tags       lowercase search terms (year, subject, key stage, etc.)
//   featured   reserved for future use (e.g. highlighting a new doc)
//   status     'published' | 'draft' — only 'published' entries render
window.CURRICULUM_REGISTRY = [
  {
    id: 'inspire-year-7',
    slug: 'inspire-year-7',
    title: 'Year 7 Maths & Science Curriculum Guide',
    description: 'A parent-friendly introduction to the Key Stage 3 mathematics and science curriculum and the foundations pupils begin building in Year 7.',
    category: 'inspire-guide',
    yearGroup: 'Year 7',
    keyStage: 'Key Stage 3',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/year-7/Inspire_Year_7_Maths_Science_England_Curriculum_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/year-7/Inspire_Year_7_Maths_Science_England_Curriculum_Guide.docx',
    order: 1,
    tags: ['year 7', 'ks3', 'key stage 3', 'maths', 'mathematics', 'science', 'inspire'],
    featured: false,
    status: 'published'
  },
  {
    id: 'inspire-year-8',
    slug: 'inspire-year-8',
    title: 'Year 8 Maths & Science Curriculum Guide',
    description: 'A guide to developing stronger connections, application and independence across Key Stage 3 mathematics and science.',
    category: 'inspire-guide',
    yearGroup: 'Year 8',
    keyStage: 'Key Stage 3',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/year-8/Inspire_Year_8_Maths_Science_England_Curriculum_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/year-8/Inspire_Year_8_Maths_Science_England_Curriculum_Guide.docx',
    order: 2,
    tags: ['year 8', 'ks3', 'key stage 3', 'maths', 'mathematics', 'science', 'inspire'],
    featured: false,
    status: 'published'
  },
  {
    id: 'inspire-year-9',
    slug: 'inspire-year-9',
    title: 'Year 9 Maths & Science Curriculum Guide',
    description: 'A guide to completing and consolidating Key Stage 3 knowledge while preparing for the transition into GCSE study.',
    category: 'inspire-guide',
    yearGroup: 'Year 9',
    keyStage: 'Key Stage 3 / GCSE transition',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/year-9/Inspire_Year_9_Maths_Science_England_Curriculum_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/year-9/Inspire_Year_9_Maths_Science_England_Curriculum_Guide.docx',
    order: 3,
    tags: ['year 9', 'ks3', 'key stage 3', 'gcse transition', 'maths', 'mathematics', 'science', 'inspire'],
    featured: false,
    status: 'published'
  },
  {
    id: 'inspire-year-10',
    slug: 'inspire-year-10',
    title: 'Year 10 Maths & Science Curriculum Guide',
    description: 'A guide to GCSE-stage mathematics and science learning, cumulative knowledge development and growing examination competence.',
    category: 'inspire-guide',
    yearGroup: 'Year 10',
    keyStage: 'Key Stage 4 / GCSE',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/year-10/Inspire_Year_10_Maths_Science_England_Curriculum_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/year-10/Inspire_Year_10_Maths_Science_England_Curriculum_Guide.docx',
    order: 4,
    tags: ['year 10', 'ks4', 'key stage 4', 'gcse', 'maths', 'mathematics', 'science', 'inspire'],
    featured: false,
    status: 'published'
  },
  {
    id: 'inspire-year-11',
    slug: 'inspire-year-11',
    title: 'Year 11 Maths & Science Curriculum Guide',
    description: 'A guide to completing, connecting, retrieving and applying GCSE mathematics and science knowledge during the final examination year.',
    category: 'inspire-guide',
    yearGroup: 'Year 11',
    keyStage: 'Key Stage 4 / GCSE',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/year-11/Inspire_Year_11_Maths_Science_England_Curriculum_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/year-11/Inspire_Year_11_Maths_Science_England_Curriculum_Guide.docx',
    order: 5,
    tags: ['year 11', 'ks4', 'key stage 4', 'gcse', 'maths', 'mathematics', 'science', 'inspire'],
    featured: false,
    status: 'published'
  },
  {
    id: 'inspire-gcse-readiness',
    slug: 'inspire-gcse-readiness',
    title: 'GCSE Maths & Science Readiness Guide',
    description: 'A practical readiness framework for checking mathematical and scientific foundations, identifying gaps and preparing successfully for GCSE study and examinations.',
    category: 'inspire-guide',
    yearGroup: 'GCSE Readiness',
    keyStage: 'GCSE preparation and examination readiness',
    subject: 'Maths & Science',
    publisher: 'Inspire Academic',
    official: false,
    reference: null,
    pdfUrl: '/resources/curriculum/inspire/gcse-readiness/Inspire_GCSE_Maths_Science_Readiness_Guide.pdf',
    wordUrl: '/resources/curriculum/inspire/gcse-readiness/Inspire_GCSE_Maths_Science_Readiness_Guide.docx',
    order: 6,
    tags: ['gcse readiness', 'gcse', 'ks4', 'maths', 'mathematics', 'science', 'inspire', 'exam preparation'],
    featured: false,
    status: 'published'
  },
  {
    id: 'dfe-ks3-mathematics',
    slug: 'dfe-ks3-mathematics',
    title: 'National curriculum in England: Mathematics programme of study — Key Stage 3',
    description: 'The original statutory Key Stage 3 mathematics programme of study published by the Department for Education.',
    category: 'official-dfe',
    yearGroup: null,
    keyStage: 'Key Stage 3',
    subject: 'Mathematics',
    publisher: 'Department for Education',
    official: true,
    reference: 'DFE-00179-2013',
    pdfUrl: '/resources/curriculum/dfe/DFE_KS3_Mathematics_DFE-00179-2013.pdf',
    wordUrl: null,
    order: 1,
    tags: ['dfe', 'official', 'ks3', 'key stage 3', 'maths', 'mathematics', 'national curriculum'],
    featured: false,
    status: 'published'
  },
  {
    id: 'dfe-ks3-science',
    slug: 'dfe-ks3-science',
    title: 'National curriculum in England: Science programme of study — Key Stage 3',
    description: 'The original statutory Key Stage 3 science programme of study published by the Department for Education.',
    category: 'official-dfe',
    yearGroup: null,
    keyStage: 'Key Stage 3',
    subject: 'Science',
    publisher: 'Department for Education',
    official: true,
    reference: 'DFE-00185-2013',
    pdfUrl: '/resources/curriculum/dfe/DFE_KS3_Science_DFE-00185-2013.pdf',
    wordUrl: null,
    order: 2,
    tags: ['dfe', 'official', 'ks3', 'key stage 3', 'science', 'national curriculum'],
    featured: false,
    status: 'published'
  },
  {
    id: 'dfe-ks4-mathematics',
    slug: 'dfe-ks4-mathematics',
    title: 'National curriculum in England: Mathematics programme of study — Key Stage 4',
    description: 'The original statutory Key Stage 4 mathematics programme of study published by the Department for Education.',
    category: 'official-dfe',
    yearGroup: null,
    keyStage: 'Key Stage 4',
    subject: 'Mathematics',
    publisher: 'Department for Education',
    official: true,
    reference: 'DFE-00496-2014',
    pdfUrl: '/resources/curriculum/dfe/DFE_KS4_Mathematics_DFE-00496-2014.pdf',
    wordUrl: null,
    order: 3,
    tags: ['dfe', 'official', 'ks4', 'key stage 4', 'gcse', 'maths', 'mathematics', 'national curriculum'],
    featured: false,
    status: 'published'
  },
  {
    id: 'dfe-ks4-science',
    slug: 'dfe-ks4-science',
    title: 'National curriculum in England: Science programme of study — Key Stage 4',
    description: 'The original statutory Key Stage 4 science programme of study published by the Department for Education.',
    category: 'official-dfe',
    yearGroup: null,
    keyStage: 'Key Stage 4',
    subject: 'Science',
    publisher: 'Department for Education',
    official: true,
    reference: 'DFE-00677-2014',
    pdfUrl: '/resources/curriculum/dfe/DFE_KS4_Science_DFE-00677-2014.pdf',
    wordUrl: null,
    order: 4,
    tags: ['dfe', 'official', 'ks4', 'key stage 4', 'gcse', 'science', 'national curriculum'],
    featured: false,
    status: 'published'
  }
]
