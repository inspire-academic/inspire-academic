# Protégé Rebuild — Research Synthesis & Plan (2026-09-10)

**Status: research + planning document, not a spec.** Nothing here has been
built. Four parallel research passes (one codebase audit, three external
research tracks) were commissioned to answer one question: how do we take
Protégé — Inspire's Year-3-and-up gamified maths/science module — from
"not well developed" to something that genuinely builds exceptional
capability in the children using it. This document synthesizes all four
into a single set of design principles and a phased plan. Citations for
every external claim below are in the four source tracks; the highest-value
ones are repeated inline here so this doc stands alone.

---

## Read this first — the headline finding

**There is no evidence base for "turning ordinary children into geniuses,"
and the plan should stop claiming that.** Every documented case of
exceptional early mathematical/scientific ability (SMPY's cohorts, olympiad
medalists) starts from children *already identified* as precocious —
talent-development, not talent-creation. Deliberate practice research
(Ericsson) is real but contested, and even its strongest defenders don't
claim it manufactures ability from nothing.

But underneath the overclaim is a **better, truer, and more moving story**,
and it's backed by real numbers: Agarwal & Gaule's "Invisible Geniuses"
study found that International Maths Olympiad participants from low-income
countries — matched for measured talent against rich-country peers — go on
to produce **34% fewer publications and 56% fewer citations**. The talent
is already there. What's missing is the pipeline: early exposure to hard,
interesting problems; identification that doesn't depend on an expensive
referral system; and a route from "talented 8-year-old in Kano" to
"mathematician the world hears from."

**Recommended reframe: Protégé's job is to find exceptional ability that
would otherwise go unseen, and to raise the ceiling for every child on the
platform — not to manufacture genius.** This is a stronger pitch, not a
weaker one. It's specific, evidence-backed, and it's exactly the kind of
claim that survives contact with a school, a parent, or an academic
reviewer, where "we make geniuses" would not.

---

## Part 1 — What actually exists today (codebase audit)

Files: `tools/protege.html` (904 lines, hub/launcher) and
`tools/math-genius-academy.html` (2,570 lines, the only playable game).
`netlify/functions/protege-ai.js` is a real, working, Claude-backed AI
tutor ("Professor Cosmo") — authenticated, rate-limited, with a decent
"guide, don't do homework" system prompt. `netlify/edge-functions/
protege-ai.js` is a dead unregistered duplicate, safe to delete.

**What's genuinely good and worth keeping:**
- **Times Tables engine** (`math-genius-academy.html:1282-1293`) — a real
  procedural generator covering tables 2-10, 4 progressive tiers
  (Anchors→Build→Challenge→Mastery), 4 question formats. This is already
  structurally similar to Reflex Math's fact-fluency approach (§3) — it
  just needs a spaced-repetition scheduler layered on top.
- **Non-verbal reasoning generator** (~lines 1950-2200) — procedural
  SVG-based pattern/rotation/sequence puzzles, infinite variation. Buried
  inside the game, not surfaced as its own module on the hub.
- **Professor Cosmo AI tutor** — real Claude API integration for hints and
  open chat, properly secured. This is the individualized-feedback engine
  the learning-science research says is the highest-leverage lever
  available (§2) — it already exists, it just needs to be wired into a
  much richer content/routing system.
- **3-tier mastery model** (introduced/practising/mastered, attempt-count +
  accuracy thresholds) — a reasonable foundation, not superficial, but
  currently pure accuracy-counting with no forgetting-curve/spaced-review
  logic.
- **Visual/brand craft** — genuinely matches the Fraunces/Plus Jakarta Sans
  system with spring-physics polish and its own coherent purple/violet
  "space" sub-brand. The gap is content depth, not visual quality.

**What's missing or broken:**
- **Science: 0% real content.** The hub's "Science Explorer" and "Space
  Command" cards are literal "Coming Soon" placeholders
  (`tools/protege.html:480-505`).
- **Arithmetic: only 15 hand-written questions** in a static array
  (`math-genius-academy.html:1411-1432`) — will visibly repeat within a
  few sessions.
- **"Friend battles" are fake** — hardcoded opponent names, opponent score
  is `Math.random()*15+5` on a timer, no real multiplayer infrastructure.
  Already honestly labeled "Practice Rival" from a prior de-AI-language
  pass, so not deceptive, just decorative.
- **No content-authoring pipeline** — unlike `teacher/quiz-generator.html`
  or `teacher/lesson-admin.html`, adding content means hand-editing HTML.
  Cannot scale.
- **No teacher/parent visibility** into a child's Protégé progress anywhere.
- **Age range stops at Year 4** — grade picker only offers Year 3/Year 4,
  no progression path beyond.
- **No diagnostic placement, no spaced repetition, no difficulty routing.**

---

## Part 2 — Learning science foundations (what the research says actually works)

Confidence levels are marked because some widely-cited claims (growth
mindset, "10,000 hours") are more contested than popular treatment
suggests — the plan below leans only on the well-established findings.

**Well-established, build on directly:**
- **Concreteness fading**, not just CPA: introduce a concept concrete →
  faded/pictorial → abstract, and *actively strip* the rich imagery once a
  child moves to the abstract stage — perceptually rich graphics that help
  early actively hurt later. Never let a manipulative or a cute mascot be
  the terminal representation of a concept.
- **Spaced retrieval practice** for fact fluency — an item-level scheduler
  with expanding intervals per fact, not a fixed weekly review.
- **Worked examples with fading + self-explanation prompts** for scaffolding
  new procedures — show a fully worked example, progressively remove steps,
  ask the child to explain their reasoning.
- **Guided (not open) inquiry** for science — Furtak et al.'s meta-analysis
  shows guided inquiry roughly quadruples the effect size of pure discovery
  learning. Explicit instruction in *scientific procedure* (e.g.
  control-of-variables) is necessary — probes/questions alone don't work,
  and even explicit instruction shows only small, short-lived gains at age
  7. **Back-load reasoning-skill goals (not just content) to Year 5/6.**
- **Elicit → confront → resolve** for misconceptions: open every science
  unit with a prediction the child commits to, then show the result that
  confronts it.
- **Working memory is small and undeveloped at this age** (~4 chunks,
  decaying in ~20 seconds unrehearsed; executive function doesn't
  stabilize until 9-12). Design consequence: one new idea per screen, no
  split attention (never separate instructional text from the diagram it
  describes), sessions 10-15 min for Year 3-4 rising to 20-25 min by Year 6.
- **Competence is the strongest driver of self-determined motivation**
  (ahead of autonomy and relatedness, per a 144-study/79k-student
  meta-analysis) — every design choice should ask "does this make the
  child feel more capable," not "is this fun."
- **Math anxiety forms by age 7 in up to ~50% of children**, and time
  pressure is a documented trigger. Untimed by default. No visible
  countdown. No public failure state.
- **Universal, continuous screening beats one-off referral** for finding
  exceptional ability (Card & Giuliano, PNAS) — a platform's structural
  advantage is that every attempt is already a data point; there's no need
  for a separate "gifted test."

**Real but genuinely contested — use cautiously, don't build the pitch on them:**
- **Growth mindset**: Sisk et al.'s meta-analysis puts the true effect
  near r≈.10; recent work attributes much of the apparent effect to study
  design flaws. Adopt Jo Boaler's *practices* (low-floor/high-ceiling
  tasks, de-emphasizing speed) because they're independently supported —
  not her mindset framing.
- **Interleaving**: Rohrer's classroom RCTs are impressive (roughly tripled
  delayed-test scores in one study) but not universally replicated, and
  interleaving *depresses in-session performance* — a real UX hazard in a
  gamified product if the visible reward metric reacts to it. Block during
  first acquisition of a skill; interleave only during consolidation, and
  never let the interleaved-session score drive a visible badge/level.
- **Immediate vs. delayed feedback**: a 2026 meta-analysis of 51 studies
  found no significant average effect, but classroom settings and novice
  learners lean toward immediate — the right default for this product and
  this age, but not a universal law.

**Exceptional ability**: neither "practice creates genius" nor "ability is
fixed" survives scrutiny. The defensible design goal is "never cap a
child's progression rate," not "promise a specific outcome."

---

## Part 3 — What to steal (and avoid) from existing products

**Steal:**
- **Zearn's mastery gate with no time pressure** — but note the finding
  that mattered most: gains only appeared above a **dosage threshold (3+
  lessons/week)**, and a large district trial found *zero* effect without
  adult/teacher follow-through. A progression mechanic alone isn't enough
  — the product needs a weekly-engagement design and a parent/teacher loop.
- **Reflex Math's separated fluency track** — arithmetic automaticity
  should be its own short daily loop, independent of the conceptual skill
  tree, exactly matching what the Times Tables engine already does.
- **DragonBox's discovery-before-notation sequencing** — teach the
  operation via manipulation before introducing the symbol.
- **Beast Academy's narrative-as-container** — the Afrofuturist story
  wrapper should carry the instruction, never compete with the maths for
  attention (the opposite of what makes Prodigy's ad-heavy design fail).
- **Rori (Ghana, WhatsApp AI tutor) — the single most relevant data point
  found in this whole research pass.** A text-first AI tutor delivered
  over basic handsets on low-bandwidth African networks produced an
  effect size of 0.37 (roughly an extra year of learning) in an RCT with
  ~1,000 students, grades 3-9, in Ghana. This directly validates
  Protégé's existing Cosmo AI tutor as strategically central, not a
  bolt-on feature — and validates text/audio-first design over
  video/rich-media for this exact context.
- **onebillion's onecourse (Malawi)** — offline, audio-first, tap-based
  primary numeracy with strong RCT results and **no gender gap**. This is
  the closest analogue product to what Protégé should become technically.
- **Kolibri's download-once content-pack model** — for a PWA, this means
  coarse-grained, explicitly downloadable topic packs cached via service
  worker on Wi-Fi, not per-page fetches.

**Avoid (documented failure modes, not opinions):**
- **Prodigy's pay-to-win asymmetry** — an FTC complaint documented 16
  membership ads vs. 4 math problems in 19 minutes of observed play, and
  paying members get faster progression and better cosmetics than
  non-payers. **Rule: no cosmetic or progression difference between free
  and paid tiers, ever** — a child in Kano must see the identical game a
  paying child sees.
- **IXL's punitive scoring** — a single wrong answer can erase 7-20 points
  from its "challenge zone" score, and this is documented to make children
  cry, especially those with dyscalculia/ADHD. Mastery must accumulate
  additively; a mistake should never cause a visible regression.
- **Global leaderboards structurally harm the bottom half** — multiple
  studies show low performers experience repeated public failure and
  reduced motivation. **Use pod-level cooperative goals (Inspire's
  existing 5-7 student Ubuntu pods), never a global rank.**
- **Punishing streaks are unjust on unreliable connectivity** — a streak
  broken by a dropped 2G connection, not a missed session, is a real risk
  for this platform's actual users. Use forgiving streaks (freezes, weekly
  windows, offline sessions counted on next sync).
- **Video-heavy platforms (Mystery Science, Generation Genius, BrainPOP
  Jr) will not work** under this platform's bandwidth/performance budgets
  — the pedagogy in those products is inseparable from streamed video.
  Science content here has to be built as interactive/inquiry-driven, not
  video-first.

---

## Part 4 — Talent development & the pod/mentorship mechanic

- **Difficulty design**: fluency drills (times tables, fact recall) are
  the *floor* — they free working memory, they are not the ladder to
  exceptional ability. The ladder is problems with multiple valid solution
  paths that reward the *explanation*, not just the answer. A child who
  blazes through 40 procedural questions should be routed sideways to one
  genuinely hard, unfamiliar problem — not given 40 more of the same.
- **Acceleration, not segregation**: SMPY's 35-year followup found no
  psychological harm from acceleration and a clear dose-response with
  later achievement — but rigid, *publicly labeled* ability grouping
  (setting/streaming) shows small negative effects for everyone except the
  top group. **Design consequence: accelerate the individual's content
  silently — depth-branches on the same shared topic, entered by anyone —
  never a visible tier or label.**
- **Peer teaching mechanic, tied to Inspire's existing Ubuntu pods**: peer
  tutoring research shows the *tutor* gains as much as the tutee, and
  actually teaching beats merely preparing to teach. Near-peer mentoring
  measurably improves belonging and retention, especially for
  underrepresented students. **Concrete mechanic: a topic isn't "mastered"
  until the child has recorded an explanation that another pod member
  successfully used.** This gives an advanced child a real, high-status,
  non-segregating role — near-peer mentor within their own pod — which
  converts acceleration from an exclusionary act into a contribution,
  exactly matching Inspire's Ubuntu framing already in CLAUDE.md.
- **Identification mechanism**: score continuously on rate of improvement,
  unprompted attempts at above-level problems, performance on novel
  problem types with no taught procedure, and explanation quality — not
  raw accuracy. Route silently to harder items within the same shared
  topic and narrative; add opt-in "challenge doors" any child can walk
  through. This preserves a democratizing lane (every child, matching Math
  Kangaroo's philosophy) and an identification lane (exceptional students,
  matching the olympiad pipeline) in one product, without conflating them.
- **The African-specific evidence gap is real — say so, don't paper over
  it.** AIMS/Next Einstein's outcome data is postgraduate, not applicable
  to 7-year-olds. There is essentially no published evidence base for
  early-years gifted identification in African contexts specifically —
  Protégé, done well and measured honestly, would be *generating* that
  evidence, not applying an existing playbook. Culturally-grounded content
  (ethnomathematics) has good evidence for engagement/identity, not yet
  for raising attainment — use it for what it's shown to do, don't oversell
  it as an attainment lever.

---

## Synthesized design principles (cross-track agreement)

These showed up independently across two or more of the four research
tracks — treat them as the highest-confidence design rules:

1. **Untimed, additive mastery — never a visible regression from one mistake.**
2. **Pod-level cooperative goals, never a global leaderboard.**
3. **No free/paid asymmetry in gameplay, cosmetics, or progression speed.**
4. **Gamify effort and hard-problem attempts, not speed or being right.**
5. **The AI tutor (Cosmo) is the individualization engine, not a nice-to-have** — every research track independently pointed at "individualized, feedback-rich practice at the frontier of ability" as the single highest-leverage mechanism available, and Protégé already has the infrastructure for this.
6. **Identify exceptional ability continuously and silently through use, not through a one-off test or visible tier.**
7. **Peer-teaching-to-mastery, routed through Inspire's existing pods, not a new social system.**
8. **Text/audio-first, offline-capable, service-worker-cached content — no video-dependent pedagogy.**
9. **The pitch is "find and develop exceptional ability that would otherwise be lost, and raise the ceiling for everyone" — not "make geniuses."**

---

## Recommended phased plan

This is a genuinely large rebuild — sequencing matters more than trying to
do it all at once.

**Phase 1 — Foundation (highest leverage, lowest risk)**
- Build the content-authoring pipeline (mirroring `teacher/quiz-generator.html`) so arithmetic/science content can scale past 15 hardcoded questions without hand-editing HTML.
- Layer a spaced-repetition scheduler onto the existing Times Tables engine and mastery-tracking tables (`protege_topic_mastery`) — this is additive to what already exists, not a rewrite.
- Add a diagnostic placement flow so a child starts at the right difficulty, not always at Year 3 basics.
- Remove or clearly relabel the fake "friend battles" — decide honestly whether real pod-based challenges (not global leaderboards) are worth building later.

**Phase 2 — Science, for real**
- Build actual Science content using guided-inquiry structure (predict → observe/confront → resolve), age-gated reasoning-skill goals to Year 5/6, interactive/SVG-based rather than video-based to fit the bandwidth budget.

**Phase 3 — The differentiator: pods, peer-teaching, and silent acceleration**
- Wire Protégé into Inspire's existing pod system.
- Build the "explain to your pod to complete mastery" mechanic.
- Build silent depth-routing (harder items within the same topic, opt-in challenge doors) instead of a visible gifted track.

**Phase 4 — Teacher/parent visibility**
- A read-only progress view (mirroring the pattern already built for
  attendance and other teacher tools) so an adult loop exists — Zearn's
  own research says this is load-bearing, not optional.

**Not recommended, based on this research:**
- Real-time multiplayer "friend battles" (latency-dependent, doesn't fit
  the bandwidth constraint, and leaderboard-style competition is
  documented to harm strugglers).
- Video-based science content.
- Any visible "gifted" badge, tier, or separate track.
- A growth-mindset messaging layer as a core mechanic (use Boaler's task
  design instead of mindset messaging).

---

## Open questions for Eric before building

1. Does the "find and develop exceptional ability, raise the ceiling for
   everyone" reframe land, or is there a different way you want to hold
   the ambition alongside the honest evidence base?
2. Which phase should come first in practice — is Science content the
   priority (it's currently 0%), or is the spaced-repetition/content-pipeline
   foundation more urgent even though it's less visible?
3. How central should the pod/peer-teaching mechanic be to the initial
   rebuild vs. treated as a later differentiator once the foundation is solid?
