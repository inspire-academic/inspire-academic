# App Store Launch + Ghana/WASSCE Expansion — Strategy
**Written:** 2026-08-29
**Status:** Deep research complete, no code written yet — this is the
planning document Eric asked for before any build starts.
**Scope:** Two entangled questions researched together because they turn
out to compound each other: (1) how to get Inspire Academic onto the
Apple App Store and Google Play, and (2) how to architect the platform
so a Ghanaian student sees a genuine Ghana-WASSCE product on day one —
not a reskinned GCSE app — in a way that scales to further countries
later without a rebuild.

---

## Read this first — the six findings that change the plan

1. **Ghana's curriculum is mid-reform, right now.** A new SHS curriculum
   went live November 2024. The subject names most sources (including
   many Ghanaian ones) still use — "Core Mathematics," "Elective
   Mathematics," "Integrated Science" — are being retired. Building
   against the old names ships a product that's already out of date on
   day one. See §2.

2. **The grade-prediction engine built this session (Phases 1-6 of the
   assessment-engine roadmap) cannot port to Ghana.** WAEC publishes no
   grade boundaries and no raw marks — only letter grades, after
   statistical moderation. There is no WAEC equivalent of an AQA
   boundary PDF. This isn't a data-source swap, it's a structurally
   different problem requiring its own approach. See §2.4.

3. **On iOS, in both the UK and Ghana, Apple's anti-steering rules fully
   apply.** Stripe/Paystack cannot be linked to from inside an iOS app in
   either launch market — subscriptions must go through Apple's own IAP.
   This directly changes the paid-tier design from the prior scoping
   session. See §1.3.

4. **Ghana is not open space.** SyllabusGH — Mastercard Foundation-backed,
   AI tutor, 10,000+ past questions, offline, Mobile Money payments,
   already aligned to the new 2024 curriculum — is a close, well-funded
   analogue already live in this exact market. The real gap isn't "no
   competition," it's that nobody there leads on mastery, diagnostics, or
   design craft. See §3.

5. **Country has to be a first-class dimension in the data model, not a
   value inside `exam_board`.** Grading scales run in genuinely
   incompatible directions (GCSE 9-1 vs. WASSCE A1-F9 vs. BECE's
   norm-referenced 1-9-where-1-is-best), and even "WAEC" isn't one thing —
   Ghana ran its own separate WASSCE papers from 2021-2025, only
   rejoining the shared regional exam in 2026. See §4.

6. **Android-first is the right call for Ghana specifically, on top of
   the UK-first reasoning already agreed for the paid-tier work.** Google
   Play supports MTN Mobile Money billing in Ghana directly; Apple
   accepts neither mobile money nor Apple Pay there at all. iOS in Ghana
   is a structurally weak channel independent of any store-policy
   decision. See §1.5.

---

## Part 1 — App Store / Google Play distribution

### 1.1 Technology choice: Capacitor, not React Native, not TWA-only

The codebase investigation confirms this is a genuinely clean fit:
zero native-wrapper infrastructure exists today (no `ios/`/`android/`
folders, no Capacitor/React Native dependency anywhere in `package.json`),
so there's nothing to reconcile — just a choice to make.

**Recommendation: Capacitor**, wrapping the existing vanilla-JS PWA,
targeting both stores from one codebase.

| | TWA (Android only) | **Capacitor** | React Native rewrite |
|---|---|---|---|
| Platforms | Android only | iOS + Android | iOS + Android |
| Effort from this codebase | Days | 2-6 weeks | 3-6+ months |
| Code reuse | 100% | ~95% | ~0% of UI layer |
| iOS 4.2 review credibility | N/A | Workable with native additions | Strong |

React Native means rebuilding every `div`/`span` as `View`/`Text` — a
from-scratch rebuild of a hand-authored CSS design system with inset
shadows and spring easing. Not justifiable against Capacitor's ~95%
reuse. TWA is real and cheap but Android-only — worth using as a fast
Play Store beachhead (1-2 weeks) while the Capacitor/iOS track runs
behind it, not as the whole strategy.

**One deviation from CLAUDE.md worth naming explicitly**: Capacitor
introduces npm, Xcode, and Android Studio into a project whose stated
principle is zero build step. That principle stays true for the *web*
deliverable — the native wrapper is a separate, additive toolchain, not
a change to how the website itself is built.

**Critical implementation detail**: bundle the web assets into the app
rather than pointing Capacitor's `server.url` at the live site. A
remote-URL Capacitor build is the configuration most associated with
Apple's Guideline 4.2 rejections, and it also gives no real offline
story — use Capacitor's OTA/Live Update mechanism for JS/asset-only
updates instead (Apple permits OTA updates of JS and assets, not native
code or core-functionality changes).

### 1.2 Passing Apple's Guideline 4.2 (the review-risk section)

4.2 ("Minimum Functionality") is the most common rejection reason for
wrapped web apps, and the operative test found in research is genuinely
useful: **does the feature use an iOS API the browser cannot reach?**
WebSpeech-via-browser doesn't count; the same input through
`SFSpeechRecognizer` with a real microphone permission does.

**Minimum credible bundle for first submission**, ordered by
effort-to-credibility ratio:
1. **Native push (APNs)** — revision reminders, streak nudges, "your
   marked paper is ready." Highest-value single item, and genuinely
   useful for a mastery-based product, not just review theatre.
2. **Real offline mode** — bundled app shell + downloaded lesson/past-paper
   packs on the native filesystem. A genuine, demoable differentiator
   that lines up exactly with CLAUDE.md's rural-connectivity constraint.
3. **Biometric app lock** (Face ID/Touch ID).
4. **Sign in with Apple** — required under Guideline 4.8 anyway, since
   Google OAuth is already offered.
5. Native share sheet, Universal Links, a streak/exam-countdown widget.

**New and directly relevant — Apple Guideline 5.1.2(i), added 13 Nov
2025**: apps must clearly disclose when personal data is shared with a
third-party AI and obtain explicit permission first. This platform's AI
tutor, AI question generation, and AI exam marking all trigger it. This
is a launch blocker to design for, not a polish item — and it compounds
with the child-safety requirements in §1.4, since the disclosure/consent
flow needs a parental path for under-13 users.

### 1.3 In-app purchase — the highest-stakes finding, directly affecting the paid-tier plan

**On iOS, in the UK and in Ghana, there is no legitimate way to link out
to Stripe or Paystack from inside the app.** Apple's live rule (3.1.1(a)):
*"In all other storefronts, except for the United States storefront...
apps may not include buttons, external links, or other calls to action
that direct customers to purchasing mechanisms other than in-app
purchase."* The external-purchase-link entitlement that loosened this in
the US (and, from 1 Oct 2026, the EU under DMA pressure) does **not**
cover the UK or Ghana. The UK's CMA opened a consultation on this exact
question 30 Jun 2026, closed 28 Jul 2026, decision expected "later in
2026" — direction of travel is toward loosening, but nothing is available
today and shouldn't be assumed into a launch plan.

**What this means concretely, reconciled with the just-completed
paid-tier scoping** (Stripe first/UK, Paystack staggered/Africa,
durable free tier):

- The web tier (Stripe/Paystack, already scoped) is untouched and stays
  the primary channel — this finding only affects the iOS *app*.
- **Guideline 3.1.3(b), Multiplatform Services** is the load-bearing
  mechanism: a subscription bought on the website can be honoured inside
  the iOS app, provided the same tier is *also* purchasable as a real
  IAP inside the app. This is the same pattern Kindle/Netflix use. The
  `subscriptions` table already scoped for Phase 1 of the paid-tier work
  needs a `provider` value for `apple_iap` alongside `stripe`/`paystack`,
  reconciled to the same `tier` field — this is additive to that design,
  not a redesign of it.
- **Guideline 3.1.3(c), Enterprise Services** is worth treating as a real
  business line, not a footnote: a school/MAT licensing channel, sold
  directly to institutions, is **entirely outside Apple's commission**.
  Given the paid-tier scoping's own "School/Institutional" tier
  candidate, this is a concrete reason to take that tier seriously rather
  than treating it as a someday-later add-on.
- **No price parity requirement** — the iOS IAP price can run higher than
  the web price to absorb Apple's cut (standard practice), but the app
  cannot *say* it's cheaper on the web (that itself violates
  anti-steering in the UK/Ghana).
- **Enrol in Apple's Small Business Program** (≤$1M proceeds/year) before
  first submission — drops the IAP commission from 30% to 15% from day
  one, and auto-renewing subscriptions drop to 15% after 12 months
  regardless of enrolment.

**Google Play is materially more workable.** In the UK, the Billing
Choice program (live 30 Jun 2026) already permits external links to
Stripe/Paystack alongside Play Billing. In Ghana, Play Billing itself
directly supports **MTN Mobile Money** (a live Bango-MTN Ghana
partnership) — a genuine payment-method win independent of any policy
argument, since card penetration in Ghana is under 5%.

### 1.4 Child safety and minors policy

**Ship as a general-audience app on both stores, not Kids Category.**
Apple's Kids Category tops out at ages 9-11 and structurally forbids
purchasing/links/third-party analytics — incompatible with a subscription
business and the wrong age band anyway (GCSE users are 14-16). One real
caveat: the `year6/` bridging programme targets ages 10-11 — a genuine
under-13 cohort inside an otherwise older product — so the under-13
compliance obligations below are live, not hypothetical.

- **Google Play**: declare the target audience honestly, including the
  under-13 band if the Year 6 programme is in scope for the app. Since
  the platform runs no advertising at all, most of the Play Families
  burden (ad-SDK restrictions, personalised-ad bans) simply doesn't
  apply — the remaining work is the declaration itself and a neutral age
  screen if the audience is mixed.
- **UK Age Appropriate Design Code (Children's Code)**: confirmed to
  apply — the ICO's own guidance names direct-to-consumer edtech
  explicitly. A DPIA is a real launch prerequisite, not optional. (The
  ICO's guidance is under review following the Data (Use and Access) Act
  2025 — worth a re-check closer to submission.)
- **Apple 5.1.2(i) + minors**: the AI-data-sharing consent flow from §1.2
  needs a parental-consent path specifically where the user is under 13,
  not just a generic disclosure screen.
- **COPPA** only triggers on US registrations, which aren't in scope for
  this launch — but is a genuine future dependency the moment US users
  are accepted, given the amended rule's stricter third-party-disclosure
  and data-retention requirements (full compliance required from 22 Apr
  2026).

### 1.5 Ghana/Africa distribution realities

**Android dominates and is the workable payment channel; iOS is
structurally weak in Ghana specifically, independent of any policy
choice.** Google Play accepts MTN Mobile Money directly in Ghana. Apple
accepts neither mobile money nor Apple Pay there at all — the common
local failure mode is a GH-only card that can't transact
internationally. Combined with §1.3's finding that iOS purchases must go
through Apple IAP everywhere (no link-out), **iOS in Ghana has no
legitimate payment path most Ghanaian users can actually use.**

**Practical sequencing this produces**: treat iOS-Ghana as a thin,
login-only companion honouring web-purchased entitlements (§1.3's
3.1.3(b) mechanism) rather than a real point of sale — monetise African
users on web (Paystack) and Android (Play Billing + MoMo). This is an
addition to, not a contradiction of, the already-agreed
Stripe-UK-first/Paystack-Africa-staggered sequencing: it means, within
the *app* specifically, Android should reach Ghana before iOS does, on
top of Stripe reaching production before Paystack does.

**Device/network reality**: most Ghanaian smartphones are Android,
sub-$200, and this platform's existing image budget/lazy-loading
discipline (already a CLAUDE.md hard rule) is a genuine competitive
asset here — every serious Ghanaian edtech competitor treats offline and
small app size as table stakes, not a differentiator. The rural-Kano
design test this platform already holds itself to is, in this market,
simply the price of entry.

**ASO**: "GCSE" has limited search volume in Ghana. **WASSCE, BECE, and
WAEC are the actual high-intent local search terms** — the Ghana store
listing needs to say WASSCE, not a translated version of the UK listing.

### 1.6 Cost and realistic timeline

Apple Developer Program: $99/year (requires a D-U-N-S number — budget
1-2 weeks for this alone if the company record doesn't already exist).
Google Play Developer: $25 one-time. **Register as an organisation
account, not personal** — personal accounts created after Nov 2023 must
run a 12-tester, 14-day closed test before production access;
organisation accounts are exempt entirely, saving 3-4 weeks.

Apple review: ~90% within 24 hours, but AI + minors + subscriptions apps
(this app hits all three) routinely land in a 7-10 day tail — budget for
that, not the median.

**Realistic total to first dual-store approval: ~10-14 weeks**, with a
leaner Android-only TWA beachhead reachable in 1-2 weeks if a fast Play
Store presence is wanted while the full Capacitor/iOS track runs behind
it.

---

## Part 2 — Ghana / WASSCE curriculum architecture

### 2.1 Which Ghanaian exam is the actual GCSE equivalent

**Target WASSCE, not BECE.** By recognised-qualification level (UK
NARIC/ENIC treats WASSCE as GCSE-equivalent; A1-C6 ≈ GCSE grade 4+),
WASSCE is the right match — and it's the level where Physics, Chemistry,
and Biology exist as separate subjects at all. BECE has no separate
sciences (see §2.3).

**The real cost of this choice**: WASSCE students are ~17-18, roughly
two years older than this platform's current GCSE users (14-16). This
is not a like-for-like age port — tone, examples, and UX maturity need
genuine adjustment, not just curriculum content swapped in under the
same design.

**The stakes are also different in kind, not just degree**: BECE is a
*selection* exam feeding Ghana's CSSPS placement system — anxiety is
about which named school a student gets into. WASSCE is a
*certification* exam — the critical number is the **C6 threshold** (the
"credit" grade, especially in English and Maths), the functional
equivalent of the UK's grade 4/5 pass line, and the actual number
Ghanaian students and parents organize their anxiety around. A Ghanaian
product's progress UI should be built around "are you clearing C6?" —
not a 9-1 ladder that has no meaning in this market.

### 2.2 Build for the reformed curriculum — this is a live trap

A new SHS curriculum has been live since **November 2024**, cutting SHS
subjects from 63 to ~36 and renaming three subjects central to this
platform's four-subject catalogue:

| Old name (pre-2024, still widely used online) | New name (live now) |
|---|---|
| Core Mathematics | **Mathematics** |
| Elective Mathematics | **Additional Mathematics** |
| Integrated Science | **General Science** |

Science-track students (the ones taking Physics/Chemistry/Biology) no
longer take a combined science subject at all — General Science is now
core only for *non*-science learners. This was confirmed directly from
NaCCA's own published Subject Combination Guidelines (Feb 2025), not
inferred from secondary reporting, several instances of which still
describe the old names.

**One unresolved conflict flagged by the research, worth a direct
confirmation with NaCCA before committing a data model**: whether
Science-track students take both Mathematics *and* Additional
Mathematics, or Additional Mathematics only. NaCCA's own subject table
shows both (Mathematics in the core group, Additional Mathematics as an
elective); several Ghanaian news outlets reported only the elective.
Treat NaCCA's primary document as authoritative pending that
confirmation.

### 2.3 Subject mapping — four GCSE subjects become five or six Ghanaian ones

| Inspire Academic (GCSE) | Ghana/WASSCE equivalent |
|---|---|
| Physics | **Physics** |
| Chemistry | **Chemistry** |
| Biology | **Biology** |
| Maths | **Mathematics** (core, universal) **+ Additional Mathematics** (science/STEM track) — two distinct subjects, not one |
| *(no GCSE analogue)* | **General Science** — core for every non-science SHS student; the single largest-audience science subject in the country |

This is real content-production scope, not just a relabeling exercise —
comparable in scale to standing up a new subject on the UK side, times
roughly five or six.

### 2.4 Grading — cannot reuse the assessment-engine's approach at all

Two Ghanaian scales exist, and neither works like GCSE's:

- **WASSCE**: A1 (best) down to F9 (fail), 9-point letter scale.
  **Inverted relative to GCSE's 9-1**, where 9 is best — a guaranteed
  source of confusion if any 9-1 UI logic leaks through. **WAEC
  publishes no percentage grade boundaries and releases no raw marks to
  candidates** — grades are set by statistical moderation after each
  sitting, boundaries shift sitting to sitting, and there is no WAEC
  document anywhere that plays the role AQA's published boundary PDFs
  play in the existing assessment-engine work.
- **BECE**: numeric 1 (best) to 9 (worst) — **also inverted relative to
  intuition**, and **norm-referenced** (a stanine system: your grade is
  defined by your rank against the national cohort that sitting, not a
  fixed mark threshold). Predicting a BECE grade is predicting a *rank*,
  not a score — a fundamentally different modelling problem.

**Direct implication for the assessment-engine roadmap work completed
this session**: the whole real-grade-boundary approach (Phase 1's
`REAL_GRADE_BOUNDARIES`, Phase 2's PASCO-calibrated item difficulty) has
no equivalent input data for Ghana. A Ghana grade-prediction feature
needs a structurally different approach — cohort-relative estimation
against whatever real Ghanaian past-result data can be gathered, clearly
and honestly labelled as a different, lower-confidence kind of estimate
— not a ported version of the GCSE machinery. **Recommendation: launch
Ghana without a grade-prediction claim at all initially** (mastery
tracking and topic coverage don't depend on this), and treat "real
WASSCE grade prediction" as its own later roadmap item, not a launch
blocker.

### 2.5 Schema architecture — what actually needs to change

The codebase investigation found the underlying data model is in
better shape than expected for this — most of what needs to change is
narrower and more contained than a full rebuild:

- **`exam_board` already degrades gracefully** in the two most
  load-bearing files (`dashboard.html`, `teacher/teacher.html`) — a
  non-AQA/Edexcel value already falls through to a generic "Other"
  path rather than breaking. `register.html`'s signup dropdown already
  offers an `Other` option. The gap isn't a hard block anywhere in this
  layer.
- **The real gap is `spec-map.js`**, which has no third key beyond
  `AQA`/`Edexcel` — a Ghanaian student's board selection flows through
  registration fine today, then silently renders empty subject
  dashboards because there's nothing to look up. This needs a genuine
  new entry, not a fallback fix.
- **Country needs to be a first-class dimension**, not a value nested
  inside `exam_board` — because "WAEC" is not actually one thing.
  Ghana ran its own separate WASSCE papers from 2021 to 2025 before
  rejoining the shared regional exam in 2026; a "WAEC past paper" from
  that window is a Ghana paper or a Nigeria paper, never both. Any
  future past-question/calibration pipeline (the PASCO-equivalent for
  Ghana) needs a country + sitting-variant field from day one, or it
  will silently mix incompatible papers the moment regional expansion
  happens.
- **Grading needs to become a pluggable scale, not a hardcoded array.**
  `student/report-results.html`'s `GRADE_OPTIONS=['9'...'U']` and the
  assessment-engine's `REAL_GRADE_BOUNDARIES` are both GCSE-9-1-shaped
  by construction. A `grade_scales` concept — scale values, direction
  (which end is "best"), whether it's norm-referenced, and a named pass
  threshold (GCSE's grade 4, WASSCE's C6) — keyed per curriculum system,
  is the right shape; each curriculum system's UI reads from its own
  scale rather than the code assuming 9-1 anywhere.
- **Three files hardcode a `subjectMeta` object keyed to literal
  integer ids 1-4** (`student/progress.html`, `student/topic.html`,
  `subjects.html`) for icon/colour/label display only — not gating what
  data loads, just how it's decorated. Real but narrow fix: generalise
  to a data-driven lookup so a fifth/sixth subject (General Science,
  Additional Mathematics) doesn't need three more hardcoded edits.
- **No existing i18n/locale layer at all** — genuinely nothing to
  reconcile with, which is good news: no legacy pattern to fight, but
  also nothing to lean on. Ghana doesn't need translation (English is
  Ghana's official language) — it needs curriculum vocabulary
  (WASSCE/BECE/WAEC terms, not translated GCSE terms), which is a
  content and copy question more than an engineering one.

This confirms the "never build a dead end" principle applies directly
here: introducing **country/curriculum-system as a first-class schema
dimension now** — even before a single Ghanaian lesson is written — is
cheap today and expensive to retrofit once real UK and Ghana data
coexist in the same tables.

### 2.6 Competitive landscape — a real market, and a real gap

**Not open space.** SyllabusGH — Mastercard Foundation-backed, already
aligned to the new 2024 curriculum, 10,000+ past questions back to the
1990s, AI tutor, offline, Mobile Money via Paystack, iOS/Android/APK/web
— is a close, well-resourced analogue already live in exactly this
market. uLesson (Nigerian, $25.6M raised, serves all five WAEC
countries) is the regional heavyweight most likely to expand into any
gap SyllabusGH leaves. EduStream (~$1.1M seed) is a smaller, newer
video-first entrant.

**What every serious competitor already does, confirming CLAUDE.md's
own standards rather than exceeding them**: offline-first, Mobile Money
payment, and (unhelpfully for differentiation) "AI tutor" as a marketing
claim — already commoditised in this market. The platform's existing
lingo directive (de-emphasise "AI" as a term) turns out to be
strategically correct here independent of why it was originally
adopted: "AI" is the crowded, undifferentiated claim in this exact
market.

**The real gap, and the honest case for entering anyway**: the
competitive set is breadth-first (SyllabusGH: 100+ subjects) or
functional-but-unpolished (the long tail of past-question apps). Nobody
visibly leads on **mastery-based progression, real diagnostics, or
design craft** — which is what Inspire Academic already is, not a
pivot required to compete. A depth-first, five-or-six-subject,
genuinely well-designed WASSCE product is a real, defensible position —
but it means leading with pedagogy and craft, not with "more past
questions than anyone else," since that specific race is already being
run by a well-funded incumbent.

### 2.7 Licensing — split into two conversations, launch on the tractable half

Unlike the UK (one body, AQA/Edexcel, owns both curriculum and
examination), Ghana splits this across two separate rightsholders with
very different postures:

- **NaCCA/Ministry of Education (curriculum)** — the tractable half.
  Full SHS curricula are freely downloadable public PDFs, well-structured
  (strands/content standards/learning outcomes), and — genuinely useful —
  **NaCCA has a stated process**: the documents themselves say
  reproduction requires "prior written permission from the Ministry of
  Education, Ghana," with a real contact (info@nacca.gov.gh). This is
  the same kind of tractable conversation as any curriculum-alignment
  question, and NaCCA has its own interest in adoption. **A complete,
  cleanly-licensed Ghana product can be built on curriculum alignment
  alone** — original lessons/questions written to NaCCA's standards —
  without touching a single WAEC past paper.
- **WAEC (past questions, mark schemes, examiner reports)** — the
  harder half, and **genuinely less clear than the existing AQA
  situation, not more permissive.** No published policy on third-party
  reuse exists anywhere on WAEC Ghana's own site. WAEC is demonstrably
  litigious, but the visible enforcement (56 websites pursued, arrests
  pursued) targets exam leakage and impersonation of WAEC — a different
  offence from a revision platform using genuinely past papers. At the
  same time, multiple real Ghanaian platforms (including SyllabusGH)
  visibly distribute WAEC past questions at scale with no visible
  licence and no visible objection — which could mean licences exist
  privately, or could mean nobody's been tested yet. **Recommendation**:
  treat this exactly like the standing AQA/PASCO posture — personal
  research only, no live product, until Eric has had the direct
  conversation with WAEC Ghana — and if anything, hold it *more*
  cautiously than the AQA situation given the greater ambiguity and
  WAEC's demonstrated willingness to litigate.

This produces a genuinely clean launch path: **Ghana content can launch
on NaCCA-licensed curriculum alignment alone**, with the WAEC
past-question conversation (and the calibration/grade-prediction work
that would depend on it) running in parallel on its own timeline —
exactly the same "build now, license conversation runs separately"
pattern already established and explicitly approved for PASCO/AQA.

---

## Part 3 — How the two halves compound each other

- **iOS is the weak channel in Ghana on both counts simultaneously** —
  no workable payment method (§1.5) *and* the smaller OS share there —
  which reinforces rather than complicates the Android-first sequencing
  already being recommended for other reasons.
- **The Ghana store listing needs real ASO work, not translation** —
  WASSCE/BECE/WAEC are the actual search terms; ship the UK listing
  with GCSE language and the Ghana listing with WASSCE language, from
  two different keyword sets, not one internationalised string table.
- **The "durable free tier" decision from the paid-tier scoping session
  matters even more in Ghana than assumed at the time** — the
  established local competitor (SyllabusGH) already sets the market
  expectation of a real free tier plus a premium layer, so a
  time-limited-trial approach would be visibly worse than the local
  incumbent's own offer, not just off-mission.
- **The rural-connectivity design discipline already in CLAUDE.md is a
  real competitive asset in this specific market**, not just an internal
  principle — every serious Ghanaian edtech competitor treats offline
  and small app size as table stakes, confirming rather than exceeding
  what this platform already holds itself to.

---

## Recommended phased sequence

**Phase 1 — Schema generalisation, no new content yet.**
Country/curriculum-system as a first-class dimension; pluggable grade
scales (not a hardcoded 9-1 array); generalise the three hardcoded
`subjectMeta` objects; add the missing `spec-map.js` structure for a
non-AQA/Edexcel entry. Pure architecture, low risk, unlocks everything
below — and per the "never build a dead end" principle, cheap now,
expensive to retrofit once real UK and Ghana data coexist.

**Phase 2 — NaCCA-licensed Ghana content build.**
Physics, Chemistry, Biology, Mathematics, Additional Mathematics,
General Science — lessons/topics built against NaCCA's public curricula,
no WAEC past-paper content yet. A real content-production project,
roughly comparable in scope to the UK subject build-out; needs its own
resourcing conversation with Eric (AI-assisted authoring, a Ghanaian
subject-matter reviewer, or both).

**Phase 3 — Android app store launch (TWA beachhead, then Capacitor).**
Android dominates Ghana's device market and is the only channel with a
workable local payment method (MTN Mobile Money via Play Billing); the
UK also benefits from Android's more permissive payment-linking rules.
Fastest path to a real dual-market app-store presence.

**Phase 4 — iOS launch (full Capacitor build with native bundle).**
UK-primary audience given Ghana's weak iOS payment story from §1.5;
Ghana ships as a thin, login-only companion honouring web-purchased
entitlements rather than a real point of sale there.

**Phase 5 — WAEC past-question conversation (parallel track, own
timeline).**
Same posture as the standing AQA/PASCO situation — runs independently,
doesn't block Phases 1-4, and only feeds a Ghana-specific
calibration/grade-prediction pipeline once resolved.

**Phase 6 — Regional scale beyond Ghana** (Nigeria, Sierra Leone, The
Gambia, Liberia). A shared exam board makes this cheaper than building
from scratch, not free — budget roughly 60-70% content reuse, and note
Nigeria specifically needs its own second exam board (NECO) handled
alongside WAEC.

---

## Open questions for Eric

1. **Ghana content authorship**: AI-assisted drafting reviewed by a real
   Ghanaian subject-matter expert, a direct commission to local
   educators, or something else? This is the single biggest
   resourcing decision in the whole plan.
   > **Decided 2026-09-22** (`docs/architecture-migration-plan.md` §L.1):
   > AI-assisted drafting grounded directly in NaCCA/WAEC source material,
   > with mandatory Ghanaian SME review before publication.
2. **Launch without Ghana grade-prediction, or hold Ghana launch until
   some form of it exists?** Recommendation above is launch without it
   — mastery tracking and topic coverage don't depend on it — but this
   is a real product-completeness call, not a technical one.
   > **Decided 2026-09-22** (§L.2): launch without it; mastery/diagnostic/
   > readiness indicators only. The GCSE grade-prediction engine is not
   > ported to WASSCE.
3. **How hard to push the WAEC past-question conversation, and when** —
   given the ambiguity is genuinely worse than the AQA situation, is
   this worth a direct legal consultation before any outreach, or does
   it run the same informal way the AQA conversation has?
   > **Decided 2026-09-22** (§L.3): investigation begins immediately;
   > no product ships or depends commercially on WAEC content without
   > permission. Original Inspire-authored questions in the meantime.
4. **Confirm with NaCCA directly** whether Science-track WASSCE students
   take both Mathematics and Additional Mathematics, or Additional
   Mathematics only — the one unresolved conflict in the curriculum
   research, and it changes a real data-model decision (two subjects
   stacked vs. two alternative electives).
   > **Still open as of 2026-09-22** (§L.4) — explicitly not assumed
   > into the platform pending direct NaCCA/WAEC confirmation.
