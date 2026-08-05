# Inspire Academic Science Lesson Factory — Original Brief

> **Status: reference document, not an active implementation plan.**
> Received from the team on 2026-08-05 as a master implementation brief for a
> full "lesson production system." Preserved here verbatim for future
> reference. See `docs/plans/science-lesson-factory-plan.md` (once created)
> for the actual scoped-down plan agreed with the team — the two are
> deliberately not the same document. The brief's own Section 2
> ("Anti-Overengineering Constitution") conflicts with the scale of Sections
> 4–24 as written (TypeScript/MDX/Zod content pipeline with zero prior
> presence in this repo, six permanent Claude Code subagents, a five-
> awarding-body curriculum crosswalk though this platform only supports
> AQA/Edexcel, and a parallel content architecture that doesn't reconcile
> with the already-live `lessons` table / `teacher/lesson-admin.html` /
> `student/lesson-viewer.html` pipeline). Read this brief for the
> pedagogical model and lesson-structure requirements (excellent, worth
> keeping) — not as a literal technical spec for this codebase.

The companion design reference image is at
`docs/reference/inspire-physics-topic-hub.png` (light-themed mockup — the
live site is dark navy/gold; treat the mockup as a *layout/structure*
reference per its own Section 5 framing, not a literal visual-style
source, and re-skin to the existing design system for brand consistency).

---

# INSPIRE ACADEMIC SCIENCE LESSON FACTORY

## Master Implementation Brief for Claude Code

You are working inside the existing Inspire Academic repository.

Your mission is to establish the **smallest reliable, auditable and scalable production environment** capable of creating outstanding UK secondary-school science lessons, beginning with GCSE Physics.

This is not a request to build the entire Inspire Academic platform.

This is not permission to introduce an elaborate autonomous-agent platform, a new microservice architecture, a generic CMS, a drag-and-drop page builder, or a large administrative dashboard.

Your task is to create a disciplined **lesson-production system** and use it to produce one complete benchmark topic and one publication-quality benchmark lesson.

The standard is non-negotiable:

> Inspire Academic must be capable of standing up to scrutiny from students, parents, teachers, heads of science, headteachers, awarding organisations, educational researchers, the Department for Education and institutional partners.

The system must support scientific accuracy, curriculum traceability, excellent pedagogy, tier-aware learning, robust assessment, accessibility, maintainability and human accountability.

---

# 1. GOVERNING PRODUCT PRINCIPLE

The central product principle is:

> One authoritative lesson source, rendered through adaptive Higher and Foundation pathways.

Do not build entirely separate Higher and Foundation lesson pages.

Each topic and lesson must have one canonical content model containing:

* shared core content;
* Foundation emphasis and scaffolding;
* Higher-depth content;
* formally Higher-only assessed content;
* exam-board-specific content;
* Combined Science and Separate Physics distinctions;
* assessment variants;
* diagnostic rules.

Higher Tier is the default pathway.

Foundation Tier is a selectable pathway.

Foundation students should receive:

* the same respectful and accurate core explanation;
* a clearer focus on required content;
* scaffolded worked examples;
* Foundation-appropriate practice;
* Foundation-aligned diagnostics;
* Higher-only extensions collapsed by default;
* an option to reveal Higher extensions at any time.

The platform must distinguish between:

1. core content assessed at all tiers;
2. deeper explanation useful to all learners;
3. formally Higher-only assessed content;
4. Higher-level mathematical demand;
5. exam-board-specific content.

Do not equate "Foundation" with intellectually shallow teaching.

---

# 2. ANTI-OVERENGINEERING CONSTITUTION

These rules override any architectural enthusiasm.

## 2.1 Do not create unnecessary infrastructure

Do not introduce any of the following unless the current approved lesson-production workflow demonstrably cannot operate without it:

* new microservices;
* new databases;
* event buses;
* generic workflow engines;
* complex orchestration frameworks;
* vector databases;
* custom agent runtimes;
* broad CMS platforms;
* drag-and-drop editors;
* custom authentication systems;
* analytics warehouses;
* unnecessary abstraction layers;
* speculative APIs;
* premature multi-tenancy;
* a large teacher/admin dashboard;
* a visual page builder;
* a separate repository.

Prefer:

* structured files;
* existing project patterns;
* reusable typed components;
* deterministic validation scripts;
* Git-based review;
* human approval;
* incremental integration.

## 2.2 Content before infrastructure

When choosing between:

* completing a scientifically rigorous lesson; and
* creating additional tooling,

complete the lesson unless the tooling is essential to quality, safety or repeatability.

## 2.3 Reuse the existing stack

Before making changes:

1. inspect the repository;
2. identify its framework, package manager, design system, routing, testing, database and deployment conventions;
3. document what already exists;
4. reuse existing packages and patterns wherever reasonable;
5. do not migrate frameworks;
6. do not replace working systems merely to make the architecture more elegant.

## 2.4 No silent scope expansion

If you identify a useful future capability, record it in:

`docs/backlog/lesson-platform-future-capabilities.md`

Do not implement it unless it is necessary for the benchmark lesson.

## 2.5 No autonomous publication

No agent may mark educational content as institutionally approved or publish it without explicit human approval.

## 2.6 Agents may assist; they may not become authorities

AI outputs are drafts, analyses and review findings.

Final authority remains with human reviewers.

---

# 3. FIRST ACTION: REPOSITORY DISCOVERY

Before editing code, inspect the existing repository thoroughly.

Produce:

`docs/discovery/current-platform-audit.md`

The audit must identify:

* framework and version;
* package manager;
* monorepo structure, if any;
* current apps and packages;
* current design system;
* routing model;
* database and ORM;
* existing Supabase usage;
* authentication;
* current content model;
* testing tools;
* linting and formatting;
* accessibility tooling;
* deployment configuration;
* Netlify/Vercel configuration;
* existing lesson or programme components;
* current Inspire branding assets;
* current `CLAUDE.md` files;
* current agents, skills, hooks or MCP configuration;
* potential conflicts with this brief;
* what can be reused;
* what must be added;
* what must not be disturbed.

Do not perform destructive changes during discovery.

Do not delete or rename existing architecture without explicit instruction.

After completing discovery, create a concise implementation plan at:

`docs/plans/science-lesson-factory-plan.md`

Then continue implementation without waiting for another confirmation unless a genuinely destructive or irreversible decision is required.

---

# 4. BENCHMARK SCOPE

The benchmark subject is:

**GCSE Physics**

The benchmark topic is:

**Forces and Motion**

The benchmark topic hub is:

`GCSE Physics: Forces and Motion`

The first complete benchmark lesson is:

**Distance and Displacement**

The initial lesson sequence for the topic should be represented as:

1. Distance and Displacement
2. Speed and Velocity
3. Distance–Time Graphs
4. Acceleration
5. Velocity–Time Graphs
6. Forces and Interactions
7. Mass, Weight and Gravity
8. Resultant Forces
9. Free-Body Diagrams
10. Newton's First Law
11. Newton's Second Law and `F = ma`
12. Newton's Third Law
13. Friction and Drag
14. Terminal Velocity
15. Force and Acceleration Practical
16. Topic Review and Assessment

Do not author all sixteen full lessons in this implementation.

Create:

* the complete topic map;
* the final topic-hub interface;
* the content schemas;
* the production workflow;
* the complete Distance and Displacement lesson;
* representative placeholder metadata for later lessons.

---

# 5. APPROVED TOPIC-HUB EXPERIENCE

Use the supplied reference image:

`docs/reference/inspire-physics-topic-hub.png`

Treat it as a product-design reference, not as a source of scientific truth.

The topic hub should include:

## 5.1 Top navigation

* Inspire Academic brand;
* search;
* Home;
* Courses;
* Progress;
* Resources;
* notifications;
* learner profile.

## 5.2 Left topic navigation

The sidebar should contain:

* Overview;
* Video Lesson;
* Learn;
* Notes;
* Worked Examples;
* Practical;
* Quiz;
* Exam Practice;
* Key Vocabulary;
* Exam Tips;
* Related Lessons;
* Downloads;
* Live Support.

Key Vocabulary, Exam Tips and Related Lessons must not occupy a permanent right-hand column.

They should open only when requested:

* as an accessible slide-in panel on desktop;
* as an accessible full-screen sheet or drawer on mobile.

The central content area should remain focused and uncluttered.

## 5.3 Topic-hub content

The overview should include:

* breadcrumb;
* topic title;
* topic summary;
* Higher/Foundation pathway selector;
* topic progress;
* introduction-video card;
* scientifically accurate hero diagram;
* topic objectives;
* topic overview;
* lesson sequence;
* core models and diagrams;
* required practicals and skills;
* topic mastery path;
* diagnostic;
* practice;
* exam practice;
* end-of-topic assessment;
* worksheet download;
* live tutorial call to action.

## 5.4 Tier behaviour

Higher Tier should be selected by default.

Foundation Tier should:

* preserve shared core content;
* highlight Foundation focus;
* adapt assessment and examples;
* collapse Higher-only assessed blocks;
* retain an option to reveal them;
* persist the learner's selection locally until account-level preference is implemented.

---

# 6. LESSON EXPERIENCE: DISTANCE AND DISPLACEMENT

The benchmark lesson must be sufficiently complete that a motivated learner could study independently and make measurable progress.

It must not be a thin content card containing a paragraph, one diagram and two quiz questions.

## 6.1 Lesson structure

Create the lesson with the following sections.

### A. Orientation

* lesson title;
* lesson question;
* estimated study time;
* curriculum/tier information;
* learning objectives;
* prior-knowledge requirements;
* why the concept matters.

### B. Retrieval diagnostic

Include 3–5 short retrieval questions covering:

* units of length;
* scalar quantities;
* direction;
* interpreting a simple journey.

This diagnostic should not prevent lesson access.

It should identify likely misconceptions.

### C. Core teaching

Teach carefully:

* position;
* reference point;
* distance;
* displacement;
* scalar;
* vector;
* magnitude;
* direction;
* total path length;
* straight-line change in position;
* round trips;
* positive and negative direction in one dimension.

Clarify that:

* distance cannot be negative;
* displacement may be positive, negative or zero in one-dimensional contexts depending on the chosen positive direction;
* a journey can have non-zero distance and zero displacement;
* displacement is not simply "distance with direction" unless the conceptual distinction is explained properly;
* the reference frame and chosen origin matter.

### D. Scientific representations

Include professionally authored SVG diagrams for:

1. a direct journey;
2. a journey containing a detour;
3. a round trip;
4. a one-dimensional number-line journey;
5. distance compared with displacement;
6. start and final position vectors where appropriate.

All diagrams must be:

* scientifically accurate;
* responsive;
* legible;
* keyboard accessible where interactive;
* accompanied by meaningful text descriptions;
* visually consistent with Inspire design conventions.

### E. Worked examples

Include at least three worked examples:

1. direct movement in one direction;
2. movement forward and then partially backward;
3. a round trip ending at the starting point.

For every worked example include:

* problem;
* known information;
* expert reasoning;
* calculation;
* unit;
* final answer;
* common wrong approach;
* why the wrong approach fails.

### F. Guided practice

Include scaffolded questions that gradually remove support.

Use:

* hints;
* staged reveal;
* calculation fields where appropriate;
* explanatory feedback;
* not merely correct/incorrect indicators.

### G. Misconception clinic

Address at least:

* "distance and displacement are always equal";
* "displacement must be positive";
* "zero displacement means no movement occurred";
* "the longest route gives the largest displacement";
* "distance contains direction."

### H. Foundation pathway

Foundation mode should include:

* concise Foundation focus;
* accessible values;
* direct and single-step applications initially;
* strong support for interpreting words such as total, final position and direction;
* Foundation-aligned practice;
* Foundation exam-style questions.

Do not remove scientifically valuable explanations unless formally unnecessary and cognitively disruptive.

### I. Higher pathway

Higher mode should include:

* signed displacement;
* multiple-stage journeys;
* unfamiliar contexts;
* deeper vector reasoning;
* graph or coordinate interpretation where appropriate;
* linked calculations;
* Grade 7–9 challenge.

Clearly distinguish:

* Higher depth;
* formally Higher-only assessed content;
* shared content assessed with greater demand.

### J. Independent practice

Include a balanced question set covering:

* recall;
* definition;
* diagram interpretation;
* direct calculation;
* unfamiliar application;
* explanation;
* comparison;
* misconception diagnosis.

### K. Exam practice

Provide exam-board-style questions without reproducing copyrighted past-paper material.

Each question must have:

* mark allocation;
* tier;
* assessment objective;
* difficulty;
* specification references;
* complete mark scheme;
* model answer;
* examiner-style commentary;
* common errors.

### L. Lesson close

Include:

* retrieval exit check;
* confidence rating;
* mastery summary;
* misconception flags;
* next-step recommendation;
* next lesson link.

---

# 7. CURRICULUM AUTHORITY AND TRACEABILITY

Create an authoritative curriculum crosswalk for Forces and Motion.

Use official source documents supplied to the repository, or clearly record any source documents still required.

Do not rely on model memory for specification references.

Create:

`curriculum/physics/gcse/forces-and-motion/coverage.yaml`

It must support:

* DfE GCSE science subject content;
* AQA GCSE Physics;
* AQA Combined Science;
* Pearson Edexcel GCSE Physics;
* Pearson Edexcel Combined Science;
* OCR Gateway Physics;
* OCR Gateway Combined Science;
* OCR Twenty First Century Physics where included;
* Foundation;
* Higher;
* Combined Science;
* Separate Physics;
* equations;
* mathematical skills;
* working scientifically;
* required/core practicals;
* assessment objectives;
* prerequisite concepts;
* misconceptions.

Each curriculum item should have a stable internal identifier.

Example shape:

```yaml
id: PHY-FM-DISPLACEMENT-001
statement: Distinguish between distance travelled and displacement.
authority:
  dfe:
    reference: TO_BE_VERIFIED
  aqa:
    reference: TO_BE_VERIFIED
  edexcel:
    reference: TO_BE_VERIFIED
  ocr_gateway:
    reference: TO_BE_VERIFIED
qualification_routes:
  combined: true
  separate: true
tiers:
  foundation: true
  higher: true
assessment_objectives:
  - AO1
  - AO2
maths_skills:
  - use_signed_values
  - calculate_total_path
status:
  mapped: false
  verified_by_human: false
```

Never invent a missing reference.

Use `TO_BE_VERIFIED` and block institutional approval until verified.

Create a generated curriculum-coverage report showing:

* taught;
* practised;
* assessed;
* practical-linked;
* tier-linked;
* human-verified.

---

# 8. CONTENT MODEL

Use structured content rather than hard-coding every lesson directly into page components.

Adapt the implementation to the existing stack.

Prefer a combination such as:

* YAML for metadata and curriculum mapping;
* MDX or structured JSON for manuscripts;
* JSON for questions and mark schemes;
* SVG for scientific diagrams;
* media metadata files for video;
* TypeScript schemas and validators.

Create a typed lesson model.

Indicative shape:

```ts
type TierApplicability =
  | "all"
  | "foundation-emphasis"
  | "higher-depth"
  | "higher-assessed-only";

type LessonBlock =
  | ExplanationBlock
  | RetrievalBlock
  | ScientificDiagramBlock
  | WorkedExampleBlock
  | GuidedPracticeBlock
  | MisconceptionBlock
  | PracticalBlock
  | HigherExtensionBlock
  | ExamQuestionBlock
  | DiagnosticBlock
  | SummaryBlock;

interface Lesson {
  id: string;
  subject: "physics";
  qualification: "gcse";
  topicId: string;
  slug: string;
  title: string;
  defaultTier: "higher";
  status: LessonLifecycle;
  curriculumReferences: CurriculumReference[];
  prerequisites: string[];
  objectives: LearningObjective[];
  blocks: LessonBlock[];
  media: LessonMedia;
  assessmentSets: AssessmentSetReference[];
  review: ReviewMetadata;
}
```

Use a runtime schema validator such as the project's existing solution or Zod if already appropriate.

Do not add Zod if the repository already has a suitable validator.

---

# 9. MEDIA AND VIDEO ARCHITECTURE

The current benchmark requires a replaceable video slot.

The page must support:

* poster image;
* video URL;
* duration;
* transcript;
* captions;
* status;
* provider;
* upload date;
* reviewer;
* fallback state.

Indicative media structure:

```yaml
video:
  status: coming_soon
  provider: local
  url: null
  poster: /media/physics/forces-and-motion/distance-displacement-poster.webp
  duration_seconds: 3
  captions: null
  transcript: /content/physics/forces-and-motion/distance-displacement/transcript.md
  future_admin_upload_enabled: true
```

When video status is `coming_soon`, clicking the video card should play a short Inspire-branded placeholder animation or video saying:

**Video lesson coming soon**

The implementation must make later replacement simple.

Do not build the full video-upload dashboard now.

Provide:

* the data interface;
* upload-service boundary;
* clear comments;
* placeholder API contract;
* documentation for future dashboard implementation.

Document this at:

`docs/media/video-integration-contract.md`

---

# 10. SIDEBAR AND DRAWER ARCHITECTURE

Implement reusable navigation and contextual panels.

Required behaviour:

* Overview loads topic overview;
* Video Lesson focuses the topic introduction video;
* Learn displays the teaching pathway;
* Notes opens structured notes;
* Worked Examples opens examples;
* Practical opens practical content;
* Quiz opens diagnostic/formative questions;
* Exam Practice opens examination questions;
* Key Vocabulary opens a drawer;
* Exam Tips opens a drawer;
* Related Lessons opens a drawer;
* Downloads opens downloadable resources;
* Live Support opens or routes to support.

Desktop drawer requirements:

* enters from the right;
* does not permanently reduce the main content width;
* can be closed with a button;
* closes with Escape;
* traps focus correctly;
* returns focus to the triggering control;
* has an accessible label.

Mobile requirements:

* full-screen sheet or accessible drawer;
* large touch targets;
* no horizontal overflow;
* clear close action.

---

# 11. SCIENTIFIC DIAGRAM STANDARD

Create:

`standards/scientific-diagram-standard.md`

The standard must cover:

* SVG as the preferred final format;
* consistent coordinate systems;
* vector-arrow conventions;
* arrowhead sizing;
* labels;
* symbols;
* line weights;
* units;
* scale conventions;
* colour use;
* accessibility;
* responsive behaviour;
* print behaviour;
* light/dark contrast rules, even though the current product is light-theme;
* diagram review checklist;
* versioning;
* source files;
* restrictions on generative imagery.

## 11.1 Generative-image restriction

Generative image models may be used for:

* concept ideation;
* decorative thumbnails;
* mood references.

They must not be treated as the final authority for:

* force diagrams;
* ray diagrams;
* circuit diagrams;
* wave diagrams;
* graphs;
* particle diagrams;
* field diagrams;
* apparatus diagrams;
* mathematical plots.

Final instructional diagrams must be deliberately authored and reviewed.

## 11.2 Distance and displacement diagrams

Verify:

* route length;
* start and end positions;
* direction;
* vector arrow placement;
* sign convention;
* scale;
* labels;
* distinction between path and straight-line displacement.

Create SVG tests or snapshot checks where feasible.

---

# 12. ASSESSMENT STANDARD

Create:

`standards/science-assessment-standard.md`

Every assessment item must include:

* stable ID;
* subject;
* topic;
* lesson;
* tier;
* Combined/Separate applicability;
* awarding-body applicability;
* assessment objective;
* mathematical skill;
* working-scientifically skill where relevant;
* difficulty;
* marks;
* expected time;
* prompt;
* answer;
* mark scheme;
* feedback;
* misconception tags;
* source/provenance;
* reviewer status.

Question types should include:

* single-select;
* multi-select;
* numeric;
* short response;
* extended response;
* ordering;
* matching;
* graph interpretation;
* diagram interpretation;
* practical-method;
* calculation;
* explanation.

Avoid superficial quizzes.

Feedback must explain:

* why the answer is correct;
* why likely distractors are wrong;
* what concept to revisit;
* what the learner should do next.

Create validation that catches:

* missing answers;
* invalid correct-option IDs;
* missing units;
* mark totals inconsistent with mark schemes;
* missing tier metadata;
* missing curriculum references;
* unpublished questions without review status;
* duplicate IDs.

---

# 13. ACCESSIBILITY STANDARD

Create:

`standards/accessibility-standard.md`

Target current WCAG AA practices appropriate to the existing stack.

Include:

* semantic HTML;
* keyboard operation;
* focus visibility;
* heading hierarchy;
* landmarks;
* accessible drawers and dialogs;
* alt text;
* long descriptions for complex scientific diagrams;
* captions;
* transcripts;
* colour contrast;
* non-colour indicators;
* touch-target sizing;
* reduced-motion support;
* form labels;
* error identification;
* screen-reader announcements;
* accessible mathematical notation;
* responsive text;
* print accessibility where relevant.

Automate what is reasonable with the project's existing testing tools.

---

# 14. THE SIX PERMANENT CLAUDE CODE SUBAGENTS

Create project-level agents in the location supported by the installed Claude Code version, preferably:

`.claude/agents/`

Do not create more permanent agents unless justified in writing.

Each agent must have:

* narrow role;
* explicit inputs;
* explicit outputs;
* allowed tools;
* prohibited actions;
* escalation rules;
* definition of completion;
* requirement to report uncertainty;
* requirement not to approve its own output.

## 14.1 `curriculum-mapper`

Purpose:

* map official requirements;
* build curriculum crosswalks;
* identify tier and qualification distinctions;
* identify prerequisites;
* identify practical and maths requirements;
* produce coverage reports.

Must not:

* invent references;
* author final teaching prose;
* mark content human-approved;
* modify platform architecture.

Output:

* curriculum files;
* mapping report;
* unresolved-reference list.

## 14.2 `lead-science-author`

Purpose:

* author scientifically accurate manuscripts;
* sequence explanations;
* write examples;
* identify misconceptions;
* create Foundation and Higher layers;
* draft teacher notes and video scripts.

Must not:

* approve its own science;
* invent curriculum mappings;
* alter code architecture;
* produce final SVG diagrams without diagram review.

Output:

* manuscript;
* lesson objectives;
* examples;
* misconception clinic;
* video script;
* Foundation/Higher notes.

## 14.3 `assessment-designer`

Purpose:

* create retrieval, formative, diagnostic and exam-style assessment;
* map AO1/AO2/AO3;
* create mark schemes;
* create feedback;
* create misconception-based distractors;
* assign difficulty and tier.

Must not:

* copy copyrighted past-paper questions;
* mark its own items institutionally approved;
* alter teaching content silently;
* weaken assessment merely to make completion easier.

Output:

* questions;
* mark schemes;
* assessment blueprint;
* balance report.

## 14.4 `scientific-diagram-engineer`

Purpose:

* produce SVG diagrams;
* enforce diagram standards;
* generate descriptions;
* validate labels and vectors;
* maintain reusable diagram components.

Must not:

* use AI-generated raster art as a final scientific diagram;
* change scientific meaning without reporting it;
* approve its own scientific accuracy.

Output:

* SVG source;
* accessibility description;
* diagram review checklist;
* unresolved scientific questions.

## 14.5 `lesson-builder`

Purpose:

* render approved content through reusable components;
* implement tier behaviour;
* implement drawers;
* implement video state;
* implement assessments;
* maintain responsive and accessible behaviour.

Must not:

* rewrite scientific content;
* invent missing content;
* bypass schemas;
* create unrelated infrastructure;
* publish content.

Output:

* components;
* routes;
* tests;
* preview;
* technical notes.

## 14.6 `quality-auditor`

Purpose:

* independently audit completeness and consistency;
* verify equations and units;
* verify content-to-assessment alignment;
* verify tier behaviour;
* check unresolved placeholders;
* identify contradictions;
* report pass/fail findings.

Must not:

* silently fix material findings;
* approve institutional publication;
* obscure uncertainty;
* review only superficial formatting.

Output:

* machine-readable QA report;
* human-readable findings;
* severity;
* required correction;
* retest result.

---

# 15. AGENT ORCHESTRATION RULES

Do not create a free-running swarm.

Use a lead session to coordinate narrowly scoped subagents.

The required sequence is:

1. Curriculum Mapper
2. Lead Science Author
3. Assessment Designer
4. Scientific Diagram Engineer
5. Lesson Builder
6. Quality Auditor
7. Human review

Where safe, diagram and assessment work may proceed in parallel after the blueprint is stable.

Agents must not overwrite one another's work without clear attribution.

Each stage must produce an artefact that the next stage consumes.

Keep agent reports under:

`reviews/agent-reports/<lesson-id>/`

Every report should include:

* agent name;
* date;
* source commit;
* files reviewed;
* actions taken;
* unresolved issues;
* confidence;
* recommended next action.

---

# 16. LESSON LIFECYCLE

Use a controlled lifecycle:

```text
planned
→ mapped
→ blueprint-approved
→ authored
→ assessment-drafted
→ diagrams-drafted
→ built
→ qa-failed | qa-passed
→ human-science-reviewed
→ human-assessment-reviewed
→ accessibility-reviewed
→ institutional-approved
→ published
→ superseded
```

No lesson may move directly from authored to published.

Record lifecycle changes in a review log.

Do not build a complex workflow engine.

A typed status field plus validation and review records is sufficient for the benchmark.

---

# 17. QUALITY GATES

Create machine-checkable validation for all objective requirements.

## Gate A — Curriculum completeness

Must verify:

* at least one authoritative curriculum mapping;
* no invented references;
* tier tags present;
* qualification-route tags present;
* objectives mapped;
* all unresolved mappings visible.

## Gate B — Manuscript completeness

Must verify required lesson sections exist:

* orientation;
* diagnostic;
* explanation;
* diagrams;
* worked examples;
* guided practice;
* misconceptions;
* independent practice;
* exam practice;
* close.

## Gate C — Assessment integrity

Must verify:

* valid answer keys;
* valid marks;
* mark schemes;
* AO coverage;
* tier metadata;
* feedback;
* misconception tags.

## Gate D — Diagram integrity

Must verify:

* asset exists;
* SVG parses;
* accessible title/description exists;
* required labels exist;
* no broken references;
* review status recorded.

## Gate E — Accessibility

Must verify:

* automated accessibility tests;
* keyboard navigation;
* drawer focus behaviour;
* labels;
* no critical contrast failures;
* reduced-motion behaviour;
* transcripts/captions metadata.

## Gate F — Technical quality

Must verify:

* type checking;
* linting;
* unit tests;
* integration tests;
* responsive rendering;
* no console errors;
* no broken routes;
* no unresolved critical placeholders;
* production build.

## Gate G — Publication

Must verify:

* QA passed;
* science reviewer recorded;
* assessment reviewer recorded;
* accessibility reviewer recorded;
* institutional approver recorded;
* no critical/high findings open.

---

# 18. CLAUDE CODE HOOKS

Configure only high-value, low-risk hooks.

Use project settings following the installed Claude Code version.

Create hooks to:

## After editing lesson content files

Run:

* content schema validation;
* ID validation;
* curriculum-reference validation.

## After editing question files

Run:

* assessment validator;
* answer-key check;
* mark-scheme check.

## After editing SVG files

Run:

* SVG parse validation;
* accessibility metadata validation;
* optional formatting.

## Before a git commit

Run:

* lint;
* typecheck;
* targeted tests;
* content validation;
* unresolved-placeholder scan.

## When a subagent completes

Capture:

* agent identity;
* task;
* changed files;
* unresolved findings.

Hooks must:

* be deterministic;
* fail clearly;
* avoid destructive modifications;
* avoid network calls unless explicitly required;
* complete quickly;
* provide actionable errors.

Do not create hooks that rewrite educational content automatically.

Provide documentation:

`docs/engineering/claude-code-hooks.md`

---

# 19. CLAUDE.MD STRUCTURE

Create or update the root `CLAUDE.md`.

Keep it concise enough to remain useful.

It must contain:

* institutional mission;
* anti-overengineering rules;
* approved stack;
* essential commands;
* repository map;
* content-production lifecycle;
* scientific accuracy rules;
* no-invented-reference rule;
* no-silent-publication rule;
* agent orchestration;
* definition of done;
* current benchmark scope.

Use scoped `CLAUDE.md` files where appropriate:

* `curriculum/CLAUDE.md`
* `content/CLAUDE.md`
* `assessments/CLAUDE.md`
* `scientific-assets/CLAUDE.md`
* relevant application directory `CLAUDE.md`

Do not duplicate the entire root file in every directory.

Scoped files should contain only local rules.

Create `CLAUDE.local.md.example` for developer-specific notes.

Do not commit secrets or personal machine paths.

---

# 20. REUSABLE SKILLS OR COMMANDS

Create only a small number of repeatable workflows.

Suitable skills or commands include:

* `/lesson-discover`
* `/lesson-map`
* `/lesson-author`
* `/lesson-assess`
* `/lesson-diagrams`
* `/lesson-build`
* `/lesson-audit`
* `/lesson-status`

Each should:

* accept a lesson ID;
* verify prerequisites;
* call the appropriate agent;
* produce documented output;
* not skip gates;
* not publish.

Do not create broad commands such as `/build-entire-platform`.

---

# 21. MCP INTEGRATIONS

MCP is optional for the benchmark.

Do not add external MCP servers merely because they are available.

Only configure an MCP server when:

* the repository already uses that service;
* it removes a concrete manual bottleneck;
* security and trust have been reviewed;
* credentials remain outside version control.

Potential later integrations:

* GitHub for pull requests and issues;
* Netlify for deployment inspection;
* Supabase for approved content/media workflows;
* Figma if an authoritative design source exists.

For now:

* document recommended MCP integrations;
* do not install untrusted third-party servers;
* do not grant database write access unnecessarily;
* do not include credentials in `.mcp.json`.

Create:

`docs/engineering/mcp-policy.md`

---

# 22. TESTING STRATEGY

Use the repository's existing testing stack.

Add only what is necessary.

Required categories:

## Unit tests

* tier filtering;
* content-schema validation;
* assessment scoring;
* diagnostic rules;
* progress calculations;
* media-state handling.

## Component tests

* tier selector;
* drawer;
* quiz;
* worked example;
* scientific diagram;
* video placeholder;
* lesson sequence.

## Accessibility tests

* topic hub;
* benchmark lesson;
* drawers/dialogs;
* quiz interaction;
* keyboard navigation.

## End-to-end tests

At minimum:

1. open Forces and Motion topic hub;
2. switch Higher to Foundation;
3. verify Foundation preference persists;
4. open Key Vocabulary drawer;
5. close with Escape;
6. open first lesson;
7. play coming-soon video;
8. complete retrieval question;
9. reveal hint;
10. answer quick check;
11. see explanatory feedback;
12. reveal Higher extension from Foundation mode;
13. navigate to next lesson;
14. verify no console errors.

## Visual regression

Capture:

* desktop;
* tablet;
* mobile;
* Higher;
* Foundation;
* drawer open;
* quiz feedback;
* video placeholder.

Do not treat snapshots as proof of scientific correctness.

---

# 23. SECURITY AND DATA MINIMISATION

For the benchmark:

* avoid collecting unnecessary learner data;
* do not store sensitive personal information;
* use local/demo progress where account integration is absent;
* document future data requirements;
* do not bypass existing authentication;
* do not expose service-role keys;
* do not place secrets in client code;
* do not grant agents broad database access.

Any future learner analytics must have a documented educational purpose.

---

# 24. REPOSITORY STRUCTURE

Adapt to the existing repository rather than forcing this exact layout.

Aim for an equivalent structure:

```text
standards/
  science-content-standard.md
  lesson-architecture-standard.md
  science-assessment-standard.md
  scientific-diagram-standard.md
  accessibility-standard.md
  publication-qa-standard.md

curriculum/
  physics/
    gcse/
      forces-and-motion/
        coverage.yaml
        sequence.yaml
        misconceptions.yaml
        practicals.yaml
        equations.yaml

content/
  physics/
    gcse/
      forces-and-motion/
        topic.yaml
        distance-and-displacement/
          lesson.yaml
          manuscript.mdx
          teacher-notes.md
          video-script.md
          transcript.md

assessments/
  physics/
    gcse/
      forces-and-motion/
        distance-and-displacement/
          retrieval.json
          guided-practice.json
          independent-practice.json
          exam-practice.json
          mark-schemes.json

scientific-assets/
  physics/
    forces-and-motion/
      distance-and-displacement/
        direct-route.svg
        detour-route.svg
        round-trip.svg
        number-line.svg
        manifest.yaml

reviews/
  physics/
    forces-and-motion/
      distance-and-displacement/
        qa-report.json
        science-review.md
        assessment-review.md
        accessibility-review.md
        approval.md

validation/
  curriculum/
  content/
  assessment/
  diagrams/
  publication/

.claude/
  agents/
  skills/
  settings.json

docs/
  discovery/
  plans/
  reference/
  engineering/
  backlog/
  media/
```

---

# 25. REQUIRED STANDARDS DOCUMENTS

Create these before declaring the factory operational:

1. `standards/science-content-standard.md`
2. `standards/lesson-architecture-standard.md`
3. `standards/science-assessment-standard.md`
4. `standards/scientific-diagram-standard.md`
5. `standards/accessibility-standard.md`
6. `standards/publication-qa-standard.md`

Each standard must be practical and enforceable.

Avoid ceremonial policy language.

Include checklists and examples.

---

# 26. TOPIC HUB IMPLEMENTATION REQUIREMENTS

Implement the final Forces and Motion topic hub using reusable components.

It must include:

* no permanent right sidebar;
* wide central learning area;
* sidebar navigation;
* contextual drawers;
* Higher/Foundation pathway;
* topic video state;
* lesson sequence;
* completion state;
* core diagrams;
* topic objectives;
* required practicals;
* diagnostic entry;
* practice entry;
* exam-practice entry;
* end-of-topic test entry;
* downloads;
* live tutorial;
* responsive mobile layout;
* accessibility support.

Use carefully authored SVGs for all scientific visuals.

Do not reuse visually attractive but scientifically questionable AI-generated diagram details from the reference image.

---

# 27. BENCHMARK LESSON ACCEPTANCE CRITERIA

The Distance and Displacement lesson is acceptable only when:

## Curriculum

* official mapping is present;
* unverified references are visibly flagged;
* Foundation/Higher treatment is explicit;
* Combined/Separate applicability is explicit.

## Science

* distance and displacement are correctly distinguished;
* vector/scalar language is accurate;
* sign and direction are explained;
* round-trip reasoning is correct;
* diagrams are accurate;
* units are correct;
* no major misconception remains unaddressed.

## Pedagogy

* prior knowledge is activated;
* explanations are sequenced;
* examples increase in difficulty;
* guided practice reduces scaffolding;
* independent practice is substantial;
* feedback explains reasoning;
* next steps are diagnostic.

## Assessment

* AO1, AO2 and AO3 are represented appropriately;
* tier is tagged;
* mark schemes are complete;
* no copied past-paper material is used;
* exam questions are plausible and fair;
* Grade 7–9 challenge exists.

## Accessibility

* keyboard usable;
* screen-reader meaningful;
* diagrams described;
* video state accessible;
* drawer accessible;
* reduced motion supported;
* no critical automated failures.

## Engineering

* type-safe;
* lint clean;
* tests passing;
* build passing;
* responsive;
* no console errors;
* no critical unresolved placeholders;
* follows existing project architecture.

## Governance

* agent reports exist;
* QA report exists;
* human-review placeholders exist;
* content is not falsely labelled approved.

---

# 28. DEFINITION OF DONE

This implementation is done only when the repository contains:

1. current-platform audit;
2. implementation plan;
3. six standards documents;
4. curriculum crosswalk for Forces and Motion;
5. Forces and Motion topic sequence;
6. structured content schemas;
7. six specialist Claude agents;
8. small set of production skills/commands;
9. deterministic validation scripts;
10. high-value hooks;
11. final topic-hub implementation;
12. full Distance and Displacement lesson;
13. accurate SVG scientific diagrams;
14. adaptive Higher/Foundation experience;
15. assessment sets and mark schemes;
16. coming-soon video behaviour;
17. media replacement contract;
18. accessibility support;
19. automated tests;
20. QA report;
21. clear human-review gates;
22. future-capabilities backlog;
23. final handover document.

The handover document must be:

`docs/handover/science-lesson-factory-benchmark.md`

It must state:

* what was built;
* what was deliberately not built;
* how to run it;
* how to validate it;
* how to author the next lesson;
* how to replace the video;
* how agents are invoked;
* how reviews are recorded;
* what remains unverified;
* known risks;
* recommended next three actions.

---

# 29. IMPLEMENTATION PHASES

Proceed in this order.

## Phase 0 — Discovery and protection

* audit repository;
* identify existing patterns;
* protect working systems;
* create implementation plan;
* create branch if not already on an appropriate feature branch.

## Phase 1 — Institutional standards

* create standards;
* create curriculum ID conventions;
* create lesson lifecycle;
* create review model.

## Phase 2 — Structured content foundation

* create schemas;
* validators;
* example content;
* curriculum matrix;
* topic sequence.

## Phase 3 — Claude production environment

* root and scoped `CLAUDE.md`;
* six agents;
* minimal skills;
* hooks;
* permission-safe configuration;
* documentation.

## Phase 4 — Topic hub

* implement final UI;
* sidebar;
* drawers;
* tier selector;
* topic sequence;
* scientific SVGs;
* responsive behaviour.

## Phase 5 — Benchmark lesson

* author Distance and Displacement;
* create diagrams;
* create Foundation/Higher layers;
* create assessment;
* create feedback;
* create video placeholder.

## Phase 6 — Validation and QA

* run all checks;
* run agents independently;
* resolve critical/high findings;
* generate QA report;
* capture screenshots.

## Phase 7 — Handover

* document;
* list remaining human approvals;
* prepare clean commit history;
* do not merge or deploy production without explicit instruction.

---

# 30. REQUIRED WORKING STYLE

Throughout this work:

* show concise progress updates;
* preserve auditability;
* make small coherent commits;
* never claim a check passed unless it ran;
* never claim a curriculum reference is authoritative unless verified;
* record uncertainty;
* prefer explicit TODOs over invented facts;
* do not conceal incomplete work;
* do not weaken standards to achieve a green build;
* fix root causes rather than bypassing validation;
* keep user-facing language polished and British English;
* use official terms: Foundation Tier and Higher Tier;
* keep the product name Inspire Academic;
* treat scientific accuracy and accessibility as product features;
* keep the system comprehensible to future teachers and developers.

---

# 31. FINAL INSTRUCTION

Begin now with repository discovery.

Do not begin by creating agents or new architecture.

Inspect the existing system first.

Then create the audit and plan.

Proceed through the phases in order.

At the end, provide:

1. a concise implementation summary;
2. changed-file inventory;
3. commands run and their results;
4. screenshots or preview path;
5. unresolved scientific or curriculum verifications;
6. human reviews still required;
7. exact next recommended action.

Remember:

> The aim is not to build the largest system. The aim is to establish the smallest disciplined system capable of repeatedly producing scientifically exact, pedagogically excellent, accessible and auditable Inspire lessons.

> Content completion, learner value, curriculum traceability and institutional trust take priority over software expansion.
