# Protégé UI/Engagement Research — 2026-09-11

Eric's ask: investigate the best UI/interface approach for Protégé so it
genuinely engages young learners and is "super fun" to learn on. This is
a companion to `protege-rebuild-research-2026-09-10.md`, which covers
**pedagogy and product strategy** (why Protégé should work the way it
does). This doc covers a different, narrower lens: **the interface
itself** — layout, motion, sound, character design, and interaction
mechanics. Read the earlier doc first; this one assumes its constraints
as fixed (untimed by default, no visible countdown, no global
leaderboard, zero free/paid gameplay asymmetry, additive/non-punitive
mastery) and does not re-litigate them.

Three parallel research tracks, run 2026-09-11:
- **Track A** — children's UX/HCI fundamentals (ages 5-11)
- **Track B** — competitive UI teardown of best-in-class kids' apps
- **Track C** — game-feel/"juice" mechanics inside Inspire's performance budget, and Cosmo-as-mascot

---

## Headline recommendation

The single highest-confidence, cross-track-convergent finding: **make
Professor Cosmo a persistent, visible, stateful character across every
Protégé screen — not just a chat panel.** This shows up independently
in all three tracks:

- Track A (academic, HIGH confidence): children learn better from
  characters they form a *parasocial relationship* with, and characters
  that visibly "wait" for a response engage children more than static
  ones — a direct, buildable spec (an explicit waiting/idle state).
- Track B (competitive teardown): Khan Academy Kids' animal guides,
  Endless's monster characters, and Osmo's implicit "cheering friend"
  feedback tone are the strongest emotional-engagement drivers found
  across best-in-class apps — stronger than any scoring/leaderboard
  mechanic.
- Track C (technical): onebillion's Alefa character (the closest
  real-world analogue to Protégé, already established in the prior
  research doc) appears on-screen for *every* activity transition as a
  persistent presence, not confined to a dialogue box — and this is
  cheap to build: inline SVG with a small state machine, the same
  `data-stage`-driven pattern already shipped in
  `assets/js/protege-diagrams.js` for Phase 2's Science investigations.

Concretely: Cosmo should get a handful of SVG pose/expression states
(idle, thinking/loading, celebrating, gentle-nudge-on-wrong-answer) shown
in a persistent corner slot on every screen — dashboard, question card,
investigation stages — reusing the diagram-registry technique that
already exists in this codebase rather than inventing a new asset
pipeline. Cosmo's reaction can double as the correct/wrong feedback
signal itself, which is simultaneously more fun (a character responding)
and more pedagogically consistent with Protégé's non-punitive design
than a red/green flash.

**One explicit caution attached to this recommendation**: a
lower-confidence but relevant finding (Track A, single paper, "Dark
Patterns of Cuteness") is that mascot/cute design can itself become a
dark pattern when used to pressure engagement rather than support it —
the same attachment mechanism that helps learning can be misused (e.g.
"Cosmo misses you!" re-engagement nudges, guilt-based prompts). Cosmo's
design should stay strictly on the supportive side of that line — this
is a natural extension of the zero-dark-pattern commitments already
fixed in the prior research doc, not a new rule.

---

## Track A — Children's UX/HCI fundamentals (ages 5-11)

Sources: Nielsen Norman Group (children's physical/cognitive
development, "Children on the Web"), academic child-computer-interaction
literature, NordiCHI 2024, Fairplay/FTC.

**Touch targets & motor skills — HIGH confidence.**
- Ages 3-5: minimum ~2cm×2cm (~75px+) targets; tap/swipe only, no
  dragging, no two-handed gestures.
- Ages 6-8: still need large targets (5mm buttons measurably caused
  frustration); dragging over distance remains hard.
- Ages 9-12: adult-sized targets and drag/scroll are fine, but UI
  *simplicity* should still track cognitive stage, not just motor
  capability.
- **Direct implication**: Protégé's `.ans-btn` is currently one fixed
  size platform-wide (`tools/math-genius-academy.html`). With Year 5/6
  now live (added this session for Phase 2's reasoning-goal gate), this
  is the right moment to differentiate touch-target size and information
  density by grade band rather than use one size for a Year 1 child and
  a Year 6 child alike.

**Navigation & pre-literacy — HIGH confidence.**
- Ages 3-5 are pre-operational: unreliable text reading, need
  visual/audio-only instruction, one obvious task per screen, and
  *exaggerated* (not subtle) feedback — a tested 5-year-old completed a
  task mechanically without understanding it because feedback was too
  subtle.
- Ages 6-8 begin reading subtle cues but still need visual+audio paired,
  not text-only; instructions shouldn't assume a specific device
  ("use the mouse") since a mismatch caused a 7-year-old to abandon a
  task in testing.
- Ages 9-12 handle multi-step flows, more text, and abstraction
  (undo/redo) alongside concrete fallbacks.
- **Direct, buildable implication for Cosmo**: at Year 1-2, Cosmo's
  voice/audio narration should be the *primary* instruction channel, not
  on-screen text — a concrete, high-leverage use of the tutor persona
  that already exists (`netlify/functions/protege-ai.js` + the existing
  `Voice.speak` hook already present in `math-genius-academy.html`).

**Color/contrast/density — MEDIUM confidence** (general design practice,
less rigorously sourced than the NN/G findings above).
- Saturated, bright palettes read as "for kids"; muted only for calm
  contexts. Practical structure: ~60% light neutral background / 30%
  dominant hue / 10% accent, 4-6 core colors total.
- WCAG AA (4.5:1 body text, 3:1 large/bold) is the accessibility floor
  regardless of age — this should be audited against
  `assets/css/tokens.css`'s actual navy/gold/subject-accent values; not
  yet checked as part of this research pass.
- Test palettes at both 30% and 100% screen brightness — colors that
  read correctly on a bright display crush on a dim, worn, or
  hand-me-down phone, directly relevant to Inspire's device profile.

**Feedback timing/animation — MEDIUM-HIGH for raw timing numbers (general
UX, not child-specific), LOW for an "avoid overstimulation" ceiling (no
child-specific study surfaced for an upper bound).**
- ~230ms is roughly the human perceptual threshold; 100-300ms reads as
  responsive (button press ~150ms, screen transition 200-250ms, complex
  change up to ~300ms). Treat as an adult-UX baseline, not a child-tested
  rule.
- HIGH confidence, child-specific: feedback must be *emotionally
  legible*, not just correctly timed — exaggerated facial/sound cues for
  under-8s, subtler cues become interpretable from roughly age 8+.

**Sound design — LOW confidence.** No strong child-specific literature on
shared-device/no-headphones sound design turned up in this pass. Flag as
an open design problem Inspire will likely have to work out empirically,
not a solved one — see Track C for the technical side (cheap
Web-Audio-based SFX).

**Dark patterns confirmed relevant to Protégé — HIGH confidence**
(NordiCHI 2024, Fairplay/FTC). Documented child-targeting dark patterns:
arbitrary virtual currencies, character-delivered social pressure
("your friend is waiting!"), countdown timers. Children have measurably
immature executive function, so these work disproportionately well on
them versus adults. Only ~25% of children in the cited study could
independently spot manipulative wording — meaning "the child could just
say no" is not a real safety valve. This reinforces (doesn't just
repeat) the untimed/no-leaderboard/no-asymmetry constraints already
fixed in the prior research doc: the constraints have to be structural,
not disclosure-based.

---

## Track B — Competitive UI teardown

Apps reviewed: Khan Academy Kids, Duolingo (mainline + Duolingo ABC),
Prodigy Math, Toca Boca, Osmo, ABCmouse/Adventure Academy, Endless
Alphabet/Reader (Originator), ScratchJr.

**Per-app notes:**

- **Khan Academy Kids** — menu-driven, friendly animal-guide characters
  walk the child through everything; lessons capped 3-5 min (cited as
  driving a 50% completion-rate increase over longer sessions); reward =
  sound + animation on every small win; no ads/IAP. Clean model, nothing
  to avoid.
- **Duolingo (mainline)** — color-coded emotional language
  (green=success, red=hearts/mistakes, orange=streak, purple=leagues);
  loop = streaks + XP + weekly leagues (10 tiers) + hearts (lose one per
  mistake). **Flags real tension with Inspire's rules**: leagues are a
  literal global/social leaderboard, hearts are a punitive-mistake
  mechanic — both already explicitly ruled out for Protégé.
- **Duolingo ABC** — best map example found: a visual city where each
  building unlocks a lesson set, giving spatial "I'm getting somewhere"
  progression instead of a list. Interaction variety per lesson (tap,
  trace, drag, pop). ~5 min lessons, heavy audio narration. Explicitly
  stress-free/non-competitive — notably no streaks or hearts here despite
  being a Duolingo product.
- **Prodigy Math** — RPG-style world/map with wizard avatar and battles
  (framing well-established; specifics lower-confidence, not
  re-verified this pass). Reviews are consistent and sharp on one
  point: **hard pay-to-win** — pets, wands, cosmetics, faster
  progression, and whole zones gated behind paid tiers, aggressive
  membership nagging, billing complaints. Directly violates Inspire's
  zero free/paid asymmetry rule — the canonical anti-pattern to point to
  internally.
- **Toca Boca** — no levels, no win/lose, no points at all; three verbs:
  Explore, Customize, Tell stories. Ad-free, IAP-free. Proves "fun"
  doesn't require a gamification layer — it can come purely from
  expressive, toy-like interaction. Real evidence that open-ended
  sandbox play is a legitimate alternative UI model, not just a
  gamified-quiz skin.
- **Osmo** — physical-object + camera-tracked digital feedback; instant
  audio/visual confirmation the moment a real object is placed correctly
  (a musical note per correct tangram piece). Standout finding: reward
  feedback tied to a *physical, tactile* action reads as dramatically
  more satisfying than a screen-only correct/incorrect state. Hardware
  cost is the barrier here, not dark patterns — not directly applicable
  to Protégé's device profile, but useful evidence for how strong
  specific/immediate feedback beats generic feedback (see cross-app
  pattern 3 below).
- **ABCmouse / Adventure Academy** — Adventure Academy wraps subjects in
  a 3D MMO world; ad/IAP-free but reviews consistently flag hard-to-cancel
  subscription billing, weak lesson quality under the game wrapper, and
  unmoderated chat/stranger-contact concerns. Lesson: an elaborate world
  shell doesn't fix weak content underneath, and subscription billing
  itself can be a dark-pattern surface even without IAP.
- **Endless Alphabet/Reader** — each letter/word is a distinct monster
  character; dragging a letter into place triggers a unique animation of
  that monster acting out the word's meaning. Strongest example found of
  turning correctness-feedback into content itself (the "reward" teaches,
  rather than just decorating). No dark-pattern complaints found.
- **ScratchJr** — desk-of-toys visual metaphor; color-coded blocks snap
  together with icon-only labels, no reading required. No monetization,
  no ethical flags — but reviews note 5-year-olds can genuinely get stuck
  without adult/lesson scaffolding: "no reading needed" isn't the same as
  "no confusion possible."

**Cross-app patterns (recurring in 3+ apps — highest confidence for
Inspire to adopt):**

1. **Session length 3-5 minutes, chunked** (KA Kids, both Duolingo
   products, Endless) — consistent with the working-memory constraint
   already in the prior research doc (Part 2: sessions 10-15 min rising
   to 20-25 min by Year 6). Read these together as: chunk each
   activity/lesson *inside* a longer session into 3-5 min units, not a
   contradiction — the total session length and the per-activity chunk
   size are different numbers.
2. **A persistent character/mascot as the interaction's emotional
   anchor**, not just an avatar (KA Kids, Duolingo, Endless, Osmo) — see
   the Headline recommendation above.
3. **Instant, specific micro-feedback on the correct action itself**
   (sound + motion tied to *that* answer, not a generic ding) — Osmo,
   Endless, KA Kids, Duolingo all do this. A generic "Correct!" toast
   (which is what Protégé currently has) is the weak version of this
   pattern.
4. **Map/world spatial progression beats list/menu progression** for
   legibility of "how far have I come" (Duolingo ABC's city, Prodigy's
   world). Toca Boca shows this can work with *zero* scoring attached.
   This is a bigger, later redesign idea for Protégé's dashboard (currently
   a card grid) — not a near-term change.
5. **The worst-reputation apps (Prodigy, Adventure Academy) share
   monetization/billing dark patterns, not UI/interaction-design flaws**
   — their core interaction loops are actually well-regarded; it's what's
   gated or billed behind them that damages trust. This matters directly
   for Inspire: strong interaction-design craft and the zero-asymmetry
   rule are not in tension. The research shows they're independent axes,
   which is reassuring — pursuing "fun" doesn't require compromising the
   platform's existing ethical constraints.

---

## Track C — Game-feel/"juice" within Inspire's performance budget

Cross-checked against CLAUDE.md's hard limits: <200KB total initial page
weight, <80KB JS, <100KB images per page, and the explicit "does this
work for a student in rural Kano on a mid-range Android phone with 2G"
test. The prior research doc already established Rori (Ghana) and
onebillion's onecourse (Malawi) as the closest real-world analogues —
both deliberately not graphics-heavy.

**Juice techniques, cheapest first (all fit comfortably in budget):**

- **~0KB, CSS-only** — squash & stretch on tap (`transform: scale()` +
  spring easing; Inspire's own `--spring-out` token,
  `cubic-bezier(.34,1.56,.64,1)`, is already defined and underused for
  this). Micro-shake for wrong answers as a 2-3px `translateX` wiggle on
  the *button*, not the viewport (avoids the motion-sickness/scroll-jank
  real screen-shake causes on phones). Anticipation-before-reveal — the
  `.pg-reveal` opacity-delay already shipped in `protege-diagrams.js`
  for Phase 2 is exactly this technique; extend it, don't replace it.
  Combo/streak visual escalation on the existing `.combo-text` element.
- **~1-3KB, procedural SVG** — particle bursts on correct answers
  (`spawnParticles()` already exists in `math-genius-academy.html`;
  worth confirming it's DOM-node-based rather than canvas, either is
  fine on budget). Character micro-reactions: 3-5 SVG expression states
  as swappable `<path>` sets on one persistent mascot SVG, reusing the
  `PROTEGE_DIAGRAMS`-style `render(state)` contract rather than raster
  sprite frames — this is the concrete technical mechanism for the
  Headline recommendation above.
- **~2-5KB, procedural audio, zero sound files** — Web Audio API
  oscillator + exponential-decay-envelope tones for correct/wrong/
  level-up/tap (this is literally how the Chrome Dino game does its
  SFX). Given students often share one low-end device with headphones
  optional: default volume low/muted with an explicit sound toggle, and
  treat sound as reinforcement, not the primary feedback channel — visual
  feedback must carry the full signal alone.

**Anti-patterns to explicitly avoid** (all break the 2G/Kano test):
Lottie/After-Effects JSON animations (typically 50-200KB+ plus a JS
runtime), GIF/video celebration clips, sprite-sheet character animation
(each pose = a new PNG), any particle library pulling in a physics
engine, background music loops.

**Cosmo as a UI throughline — the technical spec.** onebillion's Alefa
is the closest real precedent: a persistent presence (full figure, or a
minimal pointing-hand cue) that directs attention at every activity
transition, with short spoken/written instructions at each step —
deliberately cheap, one character asset with many small pose/state
variants, driven by markup, not video. Applied to Cosmo: inline SVG with
a small state machine — idle, thinking/loading, celebrating (correct),
gentle-nudge (wrong/hint) — swapped via a `data-state` attribute,
identical mechanism to `protege-diagrams.js`'s existing `data-stage`
pattern. Cosmo in the corner of every screen, not just the AI-tutor chat
modal.

---

## Synthesized cross-track priorities

Ranked by how many tracks converged on them, highest first:

1. **Persistent, stateful Cosmo mascot on every screen** (A + B + C
   converge) — the Headline recommendation. Clear technical path via the
   existing diagram-registry pattern; near-term buildable.
2. **Specific, instant micro-feedback tied to the exact correct action**,
   replacing generic correct/wrong toasts (B + C converge; A's
   "exaggerated feedback for under-8s" finding supports it further).
   Near-term buildable using the juice techniques in Track C.
3. **Age-tiered UI density and touch-target sizing** (A, HIGH confidence,
   newly actionable now that Year 5/6 exists in the grade picker as of
   this session's Phase 2 work). Near-term, contained change to existing
   CSS.
4. **Audio-primary instruction for Year 1-2, paired visual+audio for
   Year 3+** (A, HIGH confidence) — leverages the existing `Voice.speak`
   hook and Cosmo's AI-tutor backend; near-term.
5. **Map/world spatial progression** replacing the current card-grid
   dashboard (B, cross-app pattern) — bigger redesign, not a near-term
   change; worth a dedicated design pass later, not bundled into the
   above.
6. **Sandbox/open-ended mode as a legitimate parallel format**
   (B, Toca Boca evidence) — an interesting longer-term option (e.g. for
   Science exploration outside the guided-inquiry investigations built
   in Phase 2), not an immediate build item.

**Explicitly reinforced, not new**: every dark-pattern-avoidance finding
across all three tracks (leagues, hearts, pay-to-win, countdown timers,
arbitrary currencies, guilt-based mascot pressure) lands exactly on the
constraints already fixed in `protege-rebuild-research-2026-09-10.md`.
No track surfaced a reason to loosen any of those constraints in pursuit
of "fun" — if anything, Track B's finding #5 (the worst apps' problems
are monetization, not interaction design) is direct evidence that
Inspire doesn't have to trade one for the other.

---

## Open questions for Eric

1. Priorities 1-4 above are all near-term, contained changes to the
   existing `tools/math-genius-academy.html` + `assets/js/
   protege-diagrams.js` pattern. Should this be the next build increment
   (Phase 2b, before Phase 3's pods/peer-teaching work), or does
   something else take priority first?
2. Priority 5 (map/world dashboard redesign) is a genuinely bigger visual
   design project, not a quick change — worth scoping separately (and
   possibly worth a dedicated `/design` pass to mock up before any code
   is written) rather than folding into the above.
3. Sound design (Track A flagged this as unresolved in the literature)
   will likely need to be worked out empirically rather than from
   research alone — worth planning a small real-kid usability check once
   any of the above ships to staging, rather than treating Track C's
   Web Audio approach as final without observing real reactions.
