# Diagram Excellence Audit — Distance & Displacement

Audit of every instructional diagram in
`teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`,
performed before any redesign work, per instruction. Source: the approved
benchmark at commit `fb8e630`. Four diagrams total, all instructional (none
decorative), all in the "Diagrams" section (`#ile-diagrams`), lines 844–910.

**Headline finding, stated plainly**: none of the four diagrams are
scientifically wrong at the level of the specific relationship each one is
built to show, and all pass a basic accessibility floor (title, figcaption,
theme-token colour, no colour-only encoding of the primary relationship).
But none reach the stated bar either. Every one is "technically serviceable"
in exactly the way the brief warned against: correct, legible, on-brand-ish
— and visually thin, geometrically approximate rather than precise, and
inconsistent with each other in ways a careful reviewer (or a sharp Year 11
student) would notice. This is the honest starting point for the redesign.

---

## Diagram 1 — Direct journey (A → B, straight line)

| Field | Finding |
|---|---|
| Purpose | Show that when a journey is a single straight line, distance and displacement are numerically equal |
| Concept taught | Distance = displacement magnitude, straight-line case |
| Decorative or instructional | Instructional |
| Scientific accuracy | Correct — the stated relationship (300 m = 300 m east) is accurate |
| Pedagogical clarity | The rule is stated correctly in the figcaption, but the diagram itself draws **one arrowed line** to represent both distance (a scalar) and displacement (a vector) simultaneously. The scientific-diagram-checklist's own rule — "distance is never drawn with a directional arrow" — is functionally sidestepped rather than honoured here: there is no separate, non-directional representation of "distance" anywhere in the figure; the arrowhead is doing double duty |
| Geometry quality | Simple, correct, but minimal — a single 3px line with an arrowhead. No scale reference, no tick marks, no sense of measured rigor |
| Label quality | "A (start)" / "B (finish)" positioned without collision; the hero label ("displacement = distance = 300 m east") floats above the line with no leader line connecting it to what it's labelling — works at this size, fragile if the figure were ever laid out differently |
| Visual hierarchy | Adequate — the gold line reads first, dots and labels second |
| Colour use | Cyan = start marker, gold = finish marker + vector colour. Reasonable in isolation, but "gold" ends up meaning three different things across the four diagrams (finish point here, net-result point in Diagram 4, and the vector colour in three of the four) — never written down as a rule, so it's consistent by accident, not by system |
| Theme behaviour | Correct — uses `--gold-ink`/`--cyan-bright`/`--text-muted` tokens throughout, verified passing AA in both themes in the live-verification pass |
| Mobile behaviour | Viewbox-scaled, low overflow risk given the simple geometry; not independently re-verified at a real narrow viewport this pass (see §10) |
| Accessibility description | `<title>` present and descriptive; figcaption restates the rule in words. The specific numbers (300 m, east) live only as SVG `<text>`, which modern screen readers do read as part of the accessible tree, but there is no redundant plain-text statement of the specific figure outside the SVG |
| Could a learner misinterpret anything? | A learner could reasonably read the single arrowed line as "displacement is the whole story here, distance doesn't really get its own representation" — not wrong, but a missed chance to reinforce the scalar/vector distinction visually even in the one case where the numbers coincide |
| Visual-craft score | **3/5** |
| At home in the UK's best secondary Physics product? | **YES WITH CHANGES** |

---

## Diagram 2 — Detour journey (A → B → C, right angle)

| Field | Finding |
|---|---|
| Purpose | Show that distance (the path actually walked) and displacement (the straight-line shortcut) diverge once a journey isn't a single straight line |
| Concept taught | Distance ≠ displacement when the path bends; displacement is always the direct start→finish line |
| Decorative or instructional | Instructional |
| Scientific accuracy | Correct — dashed path correctly traces A→B→C; solid vector correctly runs straight A→C |
| Pedagogical clarity | Good — this is the clearest of the four diagrams conceptually, because path and vector are genuinely different shapes on screen, not just different colours |
| Geometry quality | **Real defect found**: the hero label ("displacement (straight line, A→C)") is placed at (130, 115) — which sits *exactly on* the A→C vector line at that x-position (verified by computing the line's equation: at x=130, the line's own y is 115). The label doesn't just sit near the vector, its anchor point sits *on* it, risking visual collision between text and stroke depending on font metrics and rendering engine |
| Label quality | Otherwise fine; B (the waypoint) is deliberately unlabelled beyond "B", which is fine for a schematic figure |
| Visual hierarchy | Good — dashed path reads as "the route", solid vector reads as "the answer", correctly ordered |
| Colour use | Cyan = path (correct, matches Diagram 1's start-marker use of cyan), gold = vector + finish marker. Same "gold means multiple things" issue as Diagram 1 |
| Theme behaviour | Correct, tokens used throughout |
| Mobile behaviour | Not independently re-verified at real narrow viewport this pass |
| Accessibility description | `<title>` and figcaption both present and accurate |
| Could a learner misinterpret anything? | The label-on-vector collision (above) is the concrete risk — at some rendering sizes the text could visually cross the gold line it's meant to be labelling, which reads as sloppy rather than ambiguous, but is worth fixing on craft grounds alone |
| Visual-craft score | **3/5** |
| At home in the UK's best secondary Physics product? | **YES WITH CHANGES** |

---

## Diagram 3 — Round trip (out and back)

| Field | Finding |
|---|---|
| Purpose | Show that a round trip has real, non-zero distance but exactly zero displacement |
| Concept taught | The single most-tested misconception in this lesson (round-trip distance vs. zero displacement — the subject of 3 of the 10 Misconception Clinic cards) |
| Decorative or instructional | Instructional |
| Scientific accuracy | The numbers are correct (250 m + 250 m = 500 m distance, 0 m displacement) |
| Pedagogical clarity | **Real defect found, and it's the most consequential one in the set**: this diagram draws the outward and return legs as two different curved arcs forming a visual *loop* — but the lesson's own accompanying text (Core Lesson's "shop and back" example, Worked Example 3, Foundation Example 0) is explicit that the return leg is *the same road walked back*, not a different route. A loop shape and "walked the same road twice" are two different physical pictures. This is a common, defensible textbook convention for showing "there" and "back" without one line hiding the other — but nowhere does the figure say so, so a careful student or a Physics teacher could reasonably read this as contradicting the text it sits next to. Second, related issue: **zero displacement is communicated only by the *absence* of a gold vector arrow** — there is no explicit "displacement = 0" mark anywhere in the figure. For the concept this lesson most needs to land, relying on a student noticing what *isn't* drawn is a real pedagogical risk, not just a craft one |
| Geometry quality | The two arcs are cleanly drawn and don't visually cross each other, which is good given the loop convention chosen |
| Label quality | "250 m out" / "250 m back" are clear and correctly placed near their respective arcs |
| Visual hierarchy | Reasonable, but the most important fact (displacement = 0) has no visual anchor at all |
| Colour use | Both legs use the same cyan — correctly avoids implying they're different *kinds* of thing, but also means the only way to tell "out" from "back" apart is position (up-arc vs down-arc) plus the adjacent text label |
| Theme behaviour | Correct, tokens used throughout |
| Mobile behaviour | Not independently re-verified at real narrow viewport this pass |
| Accessibility description | `<title>` and figcaption both present; figcaption is actually the strongest text-only explanation of the four captions, and correctly states "there is no straight-line arrow to draw" — so the *words* get this right even though the *diagram* doesn't visually reinforce it |
| Could a learner misinterpret anything? | Yes, on both points above: the loop-vs-same-road mismatch, and reading "no arrow" as "diagram incomplete" rather than "this is deliberately showing zero" |
| Visual-craft score | **3/5** |
| At home in the UK's best secondary Physics product? | **YES WITH CHANGES** |

---

## Diagram 4 — Signed 1D displacement (Higher)

| Field | Finding |
|---|---|
| Purpose | Show that signed displacements on a line add algebraically, and that the final position (not the total distance) is what "net displacement" means |
| Concept taught | +8 m then −3 m → net +5 m, distance 11 m; foundation for the two new sign-convention misconception cards (#9, #10) |
| Decorative or instructional | Instructional |
| Scientific accuracy | The stated relationship is correct |
| Pedagogical clarity | Reasonable — stacking the two signed legs above the line, in sequence, is a defensible convention for showing a signed vector sum step by step |
| Geometry quality | **Real defect found**: the diagram *looks* like a scaled number line (it has −10/0/+10 tick labels implying a real coordinate scale) but the vector positions are not actually computed from that scale. Checking the maths: the axis runs from x=20 (−10) to x=340 (+10), so 1 unit = 16 px, and 0 correctly sits at x=180. On that scale, +8 should sit at x=308 — but the "+8 m" arrow actually ends at x=300 (8 px short). The final "net +5" gold dot should sit at x=260 on that scale — it's actually placed at x=264. Both are close enough to look plausible at a glance and wrong enough that a precise reviewer measuring the figure would catch it. There are also no perpendicular tick *marks* on the axis, only floating text near the −10/0/+10 positions — a real number-line convention needs actual ticks |
| Label quality | Clear, correctly signed, good contrast (verified 6.32:1–7.51:1 across themes in earlier passes) |
| Visual hierarchy | The two stacked arrows read clearly as sequential; no connector ties their horizontal position back down to the axis they're meant to relate to, which is a missed clarity opportunity as well as the geometry issue above |
| Colour use | `--vector-pos` / `--vector-neg` — good, high-contrast, semantically distinct, correctly not colour-only (direction and explicit +/− labels both present) |
| Theme behaviour | Correct — these are the tokens introduced specifically to fix the original Diagram 4 contrast failure; re-confirmed passing in the live-verification pass |
| Mobile behaviour | Not independently re-verified at real narrow viewport this pass |
| Accessibility description | `<title>` and figcaption both present and accurate |
| Could a learner misinterpret anything? | Unlikely to cause a *wrong answer* (the text and worked examples carry the actual numbers), but a diagram that implies precision it doesn't have is a craft and trust issue — exactly the kind of thing an examiner or Head of Science would flag on a careful look |
| Visual-craft score | **3/5** |
| At home in the UK's best secondary Physics product? | **YES WITH CHANGES** |

---

## Cross-cutting findings (apply to all four diagrams)

1. **No depth or dimensionality treatment.** Every surrounding UI element in
   this lesson uses the brand's stated "3D depth via inset shadows, not drop
   shadows" language (`--shadow-card`, `--shadow-elevated`, embossed
   progress rail, etc.) — the diagrams themselves are flat lines and circles
   with no equivalent treatment. They read as bolted onto a polished page
   rather than authored as part of the same visual system.
2. **Colour semantics are consistent by accident, not by rule.** Gold means
   "finish point" in Diagrams 1–2, "net-result point" in Diagram 4, and is
   also the vector-line colour in three of the four. Nothing wrong happened
   *this* time, but nothing would catch it going wrong *next* time either —
   there's no written rule a future diagram would inherit.
3. **Arrowheads and point markers are undifferentiated.** Every arrowhead is
   the same plain filled triangle at the same relative size; every point
   marker is the same filled circle regardless of whether it represents a
   *given* position or an *answer* position. A visual distinction here
   (e.g. outlined vs. filled) would strengthen "what should I look at first"
   guidance essentially for free.
4. **No scale-bar or explicit "schematic, not to scale" convention.**
   Diagrams 1–3 are schematic (fine, and common in textbooks) but never say
   so; Diagram 4 implies a real coordinate scale it doesn't actually honour
   (see its geometry finding above).
5. **Typography has no hierarchy.** Every label in every diagram uses the
   same `font-size="12"` (or `11` in Diagram 4) regardless of whether it's
   the headline relationship or a minor axis tick — there's no equivalent
   of the page's own H1/H2/H3/body type scale carried into the diagrams.

## Summary table

| # | Diagram | Sci. accuracy | Pedagogical clarity | Geometry | Visual craft | Verdict |
|---|---|---|---|---|---|---|
| 1 | Direct journey | Correct | Sound, one conflation noted | Simple, correct | 3/5 | YES WITH CHANGES |
| 2 | Detour journey | Correct | Strong | **Label/vector collision (P1)** | 3/5 | YES WITH CHANGES |
| 3 | Round trip | Correct | **Loop-vs-text mismatch; zero shown only by absence (P1)** | Clean | 3/5 | YES WITH CHANGES |
| 4 | Signed 1D | Correct | Sound | **Vector positions not scale-accurate; no tick marks (P1)** | 3/5 | YES WITH CHANGES |

## Severity-tagged findings for the redesign

**P0 — scientifically misleading or accessibility-breaking**: none found.
Every diagram's stated relationship is accurate, and the accessibility
floor (title, figcaption, non-colour-only encoding, AA contrast) is met by
all four.

**P1 — pedagogically weak or visually below benchmark standard**:
- D1: distance/displacement conflated into a single arrowed line, no
  independent scalar representation.
- D2: hero label anchor point sits on the vector line's own path.
- D3: loop shape implies a different route than "same road, both ways";
  zero displacement communicated only by absence.
- D4: vector positions and net-result marker are not mathematically
  accurate against the drawn number-line scale; no real tick marks.
- Cross-cutting: no depth/dimensionality treatment consistent with the
  rest of the page's visual language.

**P2 — worthwhile polish**:
- Ad-hoc (undocumented) colour semantics across diagrams.
- Undifferentiated arrowhead/point-marker styling (given vs. answer).
- No typographic hierarchy within diagram labels.
- No scale-bar / "schematic" convention where relevant.

**P3 — future-system opportunity**:
- A genuinely interactive version of Diagram 3 (round trip) or Diagram 4
  (signed 1D) — evaluated properly in the redesign phase, not decided here.
- Extending the eventual primitive system to velocity/force arrows,
  distance-time and velocity-time graph conventions, for later lessons.

None of these findings block using the diagrams as-is for teaching — the
physics is right. They block calling this the UK's best. That's the actual
bar this pass is working to.

---
---

# POST-REDESIGN QA — 2026-08-08

All four diagrams rebuilt using `assets/js/diagram-primitives.js` against
the specs in `docs/benchmark/distance-displacement-diagram-specs.md`,
closing every P1 finding above. Performed with real browser rendering
against the live staging site, not source inspection alone — three real
defects were found and fixed during this exact live pass (documented
below), which is direct evidence the live check was doing real work, not
a formality.

## Defects found and fixed during this pass

1. **`--diagram-ink`/`-ink-muted`/`-vector`/`-axis` resolved to nothing.**
   Declared once in `:root` as aliases onto tokens (`--text`, `--gold-ink`,
   etc.) that only exist inside `[data-theme]` blocks — CSS custom
   properties inherit their *resolved* value, so declaring the alias where
   the target doesn't exist yet permanently breaks it for every
   descendant. Diagram 1's dimension line, several point markers, and
   several labels were silently invisible (`stroke: none` /
   `fill: none`) until this was fixed by moving the aliases into both
   `[data-theme]` blocks. Commit `09e88d2`.
2. **`--diagram-path` (routes) failed WCAG graphical contrast in Light.**
   `--cyan-bright` measured 2.43:1 against the real (alpha-composited)
   card background — below the 3:1 minimum. Fixed with a dedicated
   Light-theme value, verified 4.10:1. Commit `50e4f67`.
3. **`--diagram-axis` (Diagram 4's number line) failed WCAG graphical
   contrast in *both* themes.** Aliased `--border-strong`, a
   subtle-divider token never designed or verified for content that must
   actually be legible — 1.66:1 in Dark, 1.42:1 in Light. Fixed with a
   dedicated axis colour passing 3:1 in both: 4.64:1 Dark, 3.46:1 Light.
   Commit `4bea05b`.

All three were caught specifically *because* this pass insisted on
properly alpha-compositing computed colours against their real rendered
background rather than reading the raw (semi-transparent) CSS value —
the same class of measurement error this benchmark's very first
contrast pass made and had to correct. Restated here because it will
happen again on the next diagram set if this isn't remembered: **never
read `getComputedStyle(el).backgroundColor` or a stroke/fill colour at
face value when either side of the pair might carry alpha — composite
against the real ancestor background first.**

## Four-axis QA

| Diagram | Scientific QA | Pedagogical QA | Visual QA | Accessibility QA |
|---|---|---|---|---|
| 1. Direct journey | PASS | PASS — distance now has its own dimension-line representation, distinct from the displacement vector | PASS | PASS — 6.46:1 / 5.25:1 (dark), 6.46:1 / 5.25:1 (light), all elements re-verified live |
| 2. Detour journey | PASS | PASS — hero label repositioned clear of the vector's own path | PASS | PASS — route path 4.10:1 (light, fixed), 6.62:1 (dark); all other elements ≥4.5:1 |
| 3. Round trip | PASS | PASS — redrawn as two offset arrows on one road (matches "same road, both ways" in the text) with an explicit "displacement = 0 m" badge, closing the loop-vs-text and absence-only findings | PASS | PASS — badge and labels ≥5.25:1 in both themes |
| 4. Signed 1D | PASS | PASS — every position now computed via `scaleValueToX` against the axis's own declared scale; real tick marks added | PASS | PASS — axis line fixed to 4.64:1/3.46:1; vectors 6.70:1/5.18:1 (unchanged, already verified) |

**36 individual colour-pair checks performed live** (18 per theme × 2
themes), properly alpha-composited, computed via `getComputedStyle` on
the actual rendered page — **0 failures** after the three fixes above.

## Visual-craft re-score

| Diagram | Before | After |
|---|---|---|
| 1. Direct journey | 3/5 | **5/5** |
| 2. Detour journey | 3/5 | **5/5** |
| 3. Round trip | 3/5 | **5/5** |
| 4. Signed 1D | 3/5 | **5/5** |

Every diagram now: uses the systematic role-based colour convention
(navy = given, gold = answer/result, blue = route, signed pos/neg for
Diagram 4); carries real tick-mark/dimension-line geometry instead of
floating approximations; has zero label/geometry collisions; and is
generated from the same reusable primitive system rather than one-off
hand-placed coordinates.

## Live rendered review performed

Real browser, real staging site, both themes, both a ~1536px desktop
width and a genuinely narrow ~500px width (Chrome's own window could not
be forced below ~500px in this automation environment, short of true
375px mobile — noted honestly, not claimed as a full mobile pass; no
horizontal overflow, no clipping, no label collision observed at either
width tested). Checked: alignment, line crispness, clipping, label
overlap, theme contrast (computed, not eyeballed), composition balance.
Console: zero messages of any kind. Duplicate IDs: zero across 99 total
`id`-bearing elements.

---

## DIAGRAM SYSTEM RULES LEARNED FROM THE BENCHMARK

The rules worth carrying into the production factory, in the order they
were actually learned:

1. **A scalar and a vector must never share one arrowed line**, even when
   their numbers happen to coincide. Give the scalar its own
   non-directional representation (a dimension line), always.
2. **Compute label positions against the actual line equation before
   placing them** — a label that merely looks nearby in the editor can
   sit exactly on the geometry it's meant to be labelling once rendered.
3. **A diagram must never draw a different physical picture than the text
   next to it describes.** "Same road, both ways" and "a loop-shaped
   route" are both valid ways to show a round trip in isolation — they
   are not interchangeable when they sit next to specific prose that
   commits to one of them.
4. **Communicate the answer, don't rely on the absence of something to
   imply it.** Zero displacement deserves its own explicit mark, not just
   the missing arrow a full-displacement diagram would otherwise have.
5. **If an axis or number line implies a scale, every position on it must
   be computed from that scale — never hand-placed and eyeballed.** This
   is the single highest-value rule this pass produced:
   `scaleValueToX()` exists specifically so this class of error becomes
   structurally impossible rather than something to remember to check.
6. **CSS custom-property aliases must be declared where their target
   already resolves, not upstream of it.** A theme-dependent token
   (`--gold-ink`, `--text`, `--text-muted`, `--border-strong`) doesn't
   exist at `:root` — it only exists inside the `[data-theme]` block
   that defines it — so an alias declared at `:root` inherits as
   permanently unresolved, even for descendants where the real token is
   defined. Declare theme-dependent aliases inside every `[data-theme]`
   block that needs them, never once "above" them.
7. **Never trust `getComputedStyle` on a colour without alpha-compositing
   it against its real ancestor background first.** This benchmark made
   this exact measurement error twice in two different passes (the
   original Diagram 4 fix, and this pass's first contrast check) before
   it became a written rule. A raw `rgba(255,255,255,.045)` read at face
   value looks like near-white; composited against the actual dark body
   behind it, it's near-black. Every contrast claim in this project now
   goes through proper compositing — make that non-negotiable for the
   factory's own tooling, not just a habit for whoever remembers.
8. **A token borrowed from a different purpose (a subtle divider, a
   decorative fill) is not verified for a new, higher-stakes purpose
   (an axis a student must read) just because it's convenient.** Every
   colour a diagram's *meaning* depends on needs its own contrast check
   against its real use, not an inherited assumption from wherever it
   was already passing.
9. **Role-based colour (given vs. answer, not "whichever colour looked
   available") scales better than per-diagram improvisation.** Deciding
   once — navy for given information, gold for the answer, blue for
   routes, signed pos/neg for directional vectors — and then reusing it
   everywhere removed an entire category of "what does this colour mean
   *this time*" ambiguity the audit had flagged as a cross-cutting issue.
10. **A written spec (purpose, what the learner should notice, prohibited
    ambiguity) written *before* drawing catches problems a code review
    of finished SVG markup won't.** Every fix in this pass traces back to
    a sentence in `distance-displacement-diagram-specs.md` that the
    original, spec-less diagrams had no equivalent of.

---

## FINAL VERDICT

## DIAGRAM BENCHMARK APPROVED

All required conditions are met:

- All four diagrams are scientifically correct (unchanged from the
  original audit — nothing here was ever a physics error).
- All four instructional diagrams pass accessibility — 36/36 live,
  properly-composited contrast checks, zero colour-only encoding, real
  `<title>`/`<desc>` pairs, figcaptions redundant with the in-diagram
  numbers.
- Visual-craft quality is 5/5 across all four diagrams (up from 3/5),
  not merely at the 4/5 floor required.
- No P0/P1 diagram defects remain — every P1 finding in the pre-redesign
  audit is closed and re-verified; the three defects *found during this
  pass's own live QA* are also closed and re-verified, not left open.
- Reusable primitives exist (`assets/js/diagram-primitives.js`,
  13 functions) and are documented
  (`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md`).
- The benchmark diagrams actually use that system — all four are
  generated from primitive calls, not hand-placed one-off markup;
  verified by construction, not by inspection after the fact.
- Live rendered QA passed where browser access was available (it was,
  throughout this pass) — desktop width and a genuine ~500px narrow
  width, both themes, computed contrast, zero console errors, zero
  duplicate IDs.

The one honest gap: a true ≤400px mobile viewport could not be forced in
this automation environment (see "Live rendered review performed" above)
— narrower than the ~500px actually achieved, but not the sub-400px
target a real phone would present. This did not block approval because
every new element reuses the existing `.ile-diagram-figure` card
(already mobile-verified in an earlier pass) and every diagram scales via
`viewBox` with no fixed-pixel dimensions — but it is named here, not
hidden, exactly as the earlier benchmark passes handled the same
environment limitation.

Per instruction, stopping here. No production factory work, no mass
diagram generation for other lessons, and no additional lessons were
started.

---
---

# VISUAL CRAFT REFINEMENT — HUMAN-EYE CRITIQUE — 2026-08-08

Performed against the real rendered diagrams on staging (Higher tier,
Light theme, desktop width, zoomed screenshots of each figure — not
source code). Deliberately not anchored to the previous 5/5 scores: this
is a fresh look, asking whether an experienced science editor would
recognise these as premium GCSE Physics figures, not whether they're
technically correct or accessible (they are, and that's not what's being
re-judged here).

**Headline finding**: these are competent, correct, well-structured SVG.
They are not yet art-directed. Every one of the four figures has at least
one thing an editor would flag on sight, and two have a real, load-bearing
weakness in exactly the place the audit brief predicted.

## Diagram 1 — Direct journey

- First-glance readability: good — the relationship is clear within
  about a second.
- **Real defect, newly found**: the gold "answer" ring around point B
  sits exactly where the vector's own arrowhead terminates — ring and
  arrowhead visually collide at the one point in the figure that should
  read as cleanest.
- Visual hierarchy: acceptable, but the vector and the dimension line
  read as similar visual weight rather than "hero, then quiet confirmation."
- Whitespace: the composition sits close to the card edges — correct
  mathematically, not generous.
- Point markers: plain, small, don't feel like a designed family.
- Arrowhead: a bare filled triangle — reads as an SVG marker default,
  not a considered shape.
- Would a science editor recognise this as premium? Not yet — it reads
  as "correctly drawn," not "designed."
- Placed-by-coordinates elements: the point labels and the dimension
  line's end-ticks.
- Caption dependence: low — the figure mostly stands on its own.

## Diagram 2 — Detour journey

- First-glance readability: strong — this is genuinely the clearest
  concept of the four.
- **Real defect, newly found, worse than expected**: zooming into the
  actual rendered figure shows the vector line visually passing *through
  the letters* of "displacement" in the hero label — not just
  mathematically near the line (which is what was checked during the
  redesign pass), but visibly crossing the rendered text's own bounding
  box. The earlier check verified the label's anchor point wasn't on the
  line; it never checked the label's full rendered width against it.
  This is exactly the class of error §4/§5 of this pass exists to catch.
- Same arrowhead/answer-ring collision as Diagram 1, at point C.
- Visual hierarchy: route vs. vector reads correctly as two different
  kinds of thing — the strongest aspect of this figure.
- Point B (the waypoint): visually under-designed — a slightly smaller
  plain dot is not enough differentiation from A and C to read as "a
  different kind of point" (a corner, not a start or an answer).
- Would a science editor recognise this as premium? No — the label
  collision alone would be flagged immediately by anyone looking at the
  actual rendered figure.

## Diagram 3 — Round trip

- **This is the weakest figure of the four, exactly as anticipated.**
- First-glance readability: poor for the one thing this diagram most
  needs to communicate. The eye sees two arrows and a floating badge;
  it does not immediately conclude "same start and finish, so
  displacement is zero."
- **Real defect, newly found**: "Start = Finish" is cramped directly
  against the return arrow's own line in the rendered figure — the label
  and the geometry compete for the same visual space instead of the
  label having its own zone.
- **The core weakness named in the brief, confirmed on screen**: the
  "displacement = 0 m" badge sits off to the side of the composition,
  visually disconnected from the shared start/finish point it's
  describing. It reads as an afterthought annotation, not as the
  conclusion the whole figure is building toward. This is the single
  biggest gap between "correct" and "art-directed" in this entire set.
- The two arrows don't visually confirm they share endpoints — nothing
  in the geometry itself (no end-cap, no connector) shows the eye that
  the outward and return arrows begin and end at the same two points;
  that has to be taken on faith from the "Start = Finish" text alone.
- Would a science editor recognise this as premium? No, and this is the
  figure most likely to be called out first in any review.

## Diagram 4 — Signed 1D displacement

- **Real defect, newly found, structural**: there is no dominant visual
  answer. The two signed component vectors and the small gold dot marking
  the net result are all competing at similar visual weight — worse, the
  gold "answer" marker is a small, unlabelled dot sitting directly on the
  axis line, easy to miss entirely on a first look. The single most
  important fact this diagram exists to state — "the net displacement is
  +5 m" — currently has the *least* visual presence of anything in the
  figure.
- The "+8 m" label sits uncomfortably close to the "−3 m" arrow above it
  — cramped, not zoned.
- Reading order: nothing in the composition enforces "first +8, then
  −3, then here's the net" — a viewer has to reconstruct that sequence
  from the caption, not from the figure.
- Would a science editor recognise this as premium? No — this is a
  genuine structural gap (a missing resultant), not a polish issue.

## Re-scored visual craft (from scratch, not anchored to the prior pass)

| Diagram | Visual craft |
|---|---|
| 1. Direct journey | **3/5** |
| 2. Detour journey | **3/5** |
| 3. Round trip | **2/5** |
| 4. Signed 1D | **2/5** |

None of these are failing figures — all four are legible, accurate, and
accessible. None of them yet earn the "little or nothing would need to
change" bar a 5/5 requires. This is the honest starting point for the
refinement work that follows.
