# Visual Request — CHEM-QUANT-PFF-001

**This is a request artifact only. No image has been generated, no
asset has been integrated, no lesson has been edited.** See
`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md` v0.2 for
the four-mode representation router this request follows — this is the
first request authored directly under **Mode C (Premium Final
Figure)**.

```yaml
id: CHEM-QUANT-PFF-001
status: requested
authoringMode: premium-final-figure
lesson: Relative Formula Mass & Moles
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html
placement: "Core Lesson (#ile-learn), immediately after Stage 2 — 'The mole: a counting unit', before Stage 3"
tier: both
theme: self-contained (see THEME / FRAMING below)
aspectRatio: "3:2"
targetAsset: assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp
```

---

## WHY THIS IS MODE C, NOT SVG / GRAPH / HYBRID

**Not Mode A (deterministic SVG)**: there is no exact, assessable
geometry here. Nothing about "the mole" as a concept has a shape,
angle, or measurable length a learner could be assessed on — the value
of this figure is entirely in analogy and composition (bridging a
tangible mass on a balance to an abstract, enormous count of
particles), which is exactly the kind of thing a primitive-geometry
system has no real tool for. The three *existing* Representations in
this lesson (formula breakdown, mass↔mole relationship strip, bracket-
trap comparison) are correctly Mode A — they're exact symbolic
notation where precision is the entire point. This figure is not that;
it sits earlier in the lesson, in Core Lesson prose that currently has
**no visual at all**.

**Not Mode B (graph)**: no data, no plot.

**Not Mode D (hybrid)**: there is no specific element here that needs a
separate, machine-verifiable deterministic layer. The one genuinely
exact relationship this figure touches — n = m ÷ M<sub>r</sub> — is
already fully covered by the *existing, canonical* Representation 2
(the Mass–Mole Relationship Strip). This new figure doesn't need to
re-prove that relationship with pixel-exact geometry; it needs to make
the *concept* (a mole is a real, countable, enormous number, and you
can access it by weighing) land emotionally and intuitively. That's a
composition and illustration job, not a geometry job.

**Genuine Mode C candidate**: one coherent, art-directed composition —
a balance weighing a real substance, bridged visually to the
particle-count it represents — communicates this idea better than any
combination of separate deterministic pieces would, and the content is
fully verifiable by review (the facts stated are fixed, simple, and
already established elsewhere in this exact lesson).

## SCIENTIFIC PURPOSE

Make the lesson's own central motivating question — stated in
Orientation: *"if you can weigh a substance, how do you know how many
particles you actually have?"* — visually and intuitively answered
before the learner reaches the symbolic/calculation content later in
the lesson. Currently, Core Lesson Stage 2 ("The mole: a counting
unit") is pure prose with no supporting visual at all.

## LEARNER SHOULD NOTICE

A real, weighable mass (18 g of water) corresponds to a real, fixed,
enormous number of particles (6.02 × 10²³ molecules) — the mole is the
bridge between something you can put on a balance and something too
small and numerous to ever count directly.

## EXACT SCIENTIFIC FACTS THE FIGURE MUST STATE CORRECTLY

- 1 mole = 6.02 × 10²³ particles (the Avogadro constant).
- 1 mole of water, H₂O (relative formula mass M<sub>r</sub> = 18), has
  a mass of exactly 18 g.
- The substance shown must be water, H₂O — the same worked example
  already used earlier in this exact lesson (Core Lesson Stage 1,
  Worked Example 0), so the figure reinforces content the learner has
  already seen, not a new, unfamiliar example.

## EXACT REQUIRED LABELS / VALUES

- "18 g" (the mass on the balance/scale reading)
- "H₂O" (correct subscript — the 2 must render as a true subscript,
  not baseline text, not "H2O")
- "1 mole" or "1 mol"
- "6.02 × 10²³" (correct superscript exponent — not "10^23" as plain
  text, not "6.02 x 1023", not a misplaced or dropped exponent)
- "particles" or "molecules of H₂O" (either is acceptable; "molecules"
  is slightly more precise for this specific example and preferred if
  it fits the composition)

## NOTATION THAT MUST BE CORRECT

- H₂O: the "2" must be a true subscript, clearly smaller and
  lower-baseline than the H and O.
- 6.02 × 10²³: the "23" must be a true superscript exponent, clearly
  smaller and raised above the baseline. Use a genuine multiplication
  sign (×) between 6.02 and 10²³, not a lowercase "x".
- "M<sub>r</sub>" should **not** appear in the figure itself — this
  figure is about the mole concept, not a relative-formula-mass
  calculation; keep the figure's own text focused on mass, mole count,
  and particle count only, so it doesn't duplicate or risk contradicting
  the adjacent Representation 1/2 diagrams' own notation.

## PROHIBITED SCIENTIFIC ERRORS

- Do **not** state or imply that a mole is "one molecule" or a single
  particle (this is a named misconception this exact lesson's
  Misconception Clinic card 2 exists to prevent — the figure must not
  accidentally teach it).
- Do **not** attach a unit of "grams" directly to the word "mole"
  itself (e.g. never write "1 mole = 18 grams" as if that were a
  universal equivalence) — the correct framing is specifically about
  **this substance, water**, where 1 mole happens to have a mass of
  18 g because M<sub>r</sub>(H₂O) = 18. Phrase any mass/mole
  correspondence as tied to water specifically, not as a general law
  written without qualification.
- Do **not** show an incorrect value for the particle count (must be
  6.02 × 10²³, not a rounded/altered figure) or an incorrect mass
  (must be 18 g for water).
- Do **not** depict the particles as a countable, small, exact number
  of discrete dots that could be mistaken for a literal illustration of
  6.02 × 10²³ individual items — use an artistic device (a dense,
  shimmering cluster, a suggestion of vastness/infinity, a stylised
  molecular pattern fading into abstraction) that reads clearly as "an
  enormous, uncountable-by-eye quantity," not a diagram implying you
  could count the dots.

## DESIRED COMPOSITION

A single, cohesive scene, roughly split into two visually connected
halves:

1. **Left/foreground**: a laboratory balance or scale, tasteful and
   modern (not a cartoon), with a small labelled container/sample
   showing "18 g" and "H₂O" clearly.
2. **Right/background or emerging from the balance**: a visual bridge
   (light rays, a dissolve/particle-stream effect, or a clear
   compositional flow) leading into a dense, artistic representation of
   countless particles/molecules, annotated with "1 mole" and
   "6.02 × 10²³ [particles/molecules of H₂O]".

The composition should read left-to-right or in a single clear visual
flow (tangible → abstract), not as two unrelated panels bolted
together.

## VISUAL HIERARCHY

1. The connecting idea (mass ↔ mole ↔ particle count) is the dominant
   visual story — a viewer's eye should follow the flow from the
   balance to the particle representation.
2. The "18 g" / "H₂O" labels on the balance are the second-most
   prominent text.
3. "1 mole" and "6.02 × 10²³" are prominent but should not visually
   outweigh the compositional flow itself — this is an illustration
   with supporting labels, not an infographic dominated by text.

## STYLE

Premium modern educational illustration — the same register already
established for this platform's other Mode D asset
(`docs/visual-requests/PHY-FOR-HYB-001.md`): calm, precise, restrained,
professional digital-textbook quality. Not cartoonish, not
photorealistic stock imagery, not generic AI-infographic art, not
futuristic/sci-fi. Should feel intentionally authored for a premium
GCSE Chemistry platform — scientifically credible, not whimsical.

## THEME / FRAMING

This is a **complete, self-contained figure** (unlike the Physics
hybrid POC, which used a transparent contextual base) — it needs its
own background, not a transparent cutout, since the composition
includes an implied scene/setting (a lab bench, a sense of depth for
the particle effect) that a transparent background can't sensibly
provide.

**Generate with a soft, neutral, premium background** — a gentle
off-white or warm parchment tone, **not** stark white and **not**
transparent — so the finished figure reads as an intentional, contained
illustration card when placed inside either Inspire Dark or Inspire
Light page framing (Claude will frame it with consistent card
padding/border on integration, matching this lesson's existing
`.ile-card` treatment, regardless of which page theme is active).

## ASPECT RATIO

**3:2 (landscape)** — a genuine hero-style illustration width, wider
than the 4:3 diagrams in the Representations section, appropriate for
a Core Lesson anchor image rather than a numbered figure in a sequence.

## TARGET DISPLAY SIZE

Full width of the Core Lesson card content (`.ile-card`, effectively up
to ~848px at desktop widths, matching this lesson's other diagrams'
available width), scaling down responsively on narrower viewports via
`width:100%; height:auto`. At 3:2, that's approximately 848×565 CSS px
on desktop.

## TARGET SOURCE SIZE

Generate at the largest available size close to 3:2 landscape the
generation tool offers (e.g. in the region of 1536×1024, or the
nearest supported preset) — roughly 1.8× the display target, enough
headroom for a crisp render on high-DPI screens without generating at
an unnecessarily large source resolution.

## TARGET ASSET PATH

```
assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp
```

Following the established convention
(`assets/images/{subject}/diagrams/{topic-slug}/{id}.webp`), reusing
the existing `quantitative` topic slug already live at
`assets/images/chemistry/journey/quantitative.webp` and in
`core-topics.js`.

## SOURCE / REVIEW FILE

No repo path needed for the raw generated file, per the established
policy — keep it on your own machine until approved. Only the final,
optimised WebP goes into the target asset path above.

## ACCESSIBILITY TEXT (DRAFT)

*(Claude will finalise this at integration time; drafted here so the
requester knows what the image needs to support.)*

**Alt text:**
```
Illustration of a laboratory balance weighing 18 grams of water,
visually connected to a representation of one mole of water molecules
— 6.02 x 10^23 particles — showing that a mass you can weigh
corresponds to a precise, countable number of particles.
```

**Figcaption (page text, not baked into the image):**
```
A mole is a counting unit — the same idea as "a dozen," just for a far
larger number. Because relative formula mass tells you the mass of one
mole in grams, weighing 18 g of water on a balance is the same as
counting out 6.02 × 10²³ water molecules — you just can't see them
one at a time.
```

Per the Mode C accessibility rule (pipeline v0.2): the figure's
embedded labels are not the *only* place these facts exist — the
figcaption above restates the same scientific content as real,
selectable page text, independent of whether the image itself renders
or loads.

## PERFORMANCE TARGET

- **Target WebP size**: ≤ 60KB (matching the repo's existing hero-image
  precedent and the Physics POC's own achieved size).
- **Maximum acceptable size**: 80KB, per
  `docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md` §20 —
  leaves headroom inside CLAUDE.md's binding `<100KB total page image
  weight` budget.
- **Lazy loading**: yes — `loading="lazy"`, since this sits below the
  Orientation/Video sections in a scrollable Learn-mode page.
- **Source retention**: raw source stays off-repo, per SOURCE / REVIEW
  FILE above.

---

## COPY/PASTE INTO CHATGPT

> Generate the COMPLETE FINAL EDUCATIONAL FIGURE. Include all required
> scientific labels and annotations in the finished visual. Claude Code
> will not redraw or reconstruct them afterward — everything scientific
> must be correct and complete in the image itself.
>
> Create a premium, restrained, professional educational illustration
> for a GCSE Chemistry lesson, explaining the concept of "the mole" as
> a counting unit.
>
> Composition: a single cohesive scene, flowing left to right (or in
> one clear visual direction). On one side, show a modern laboratory
> balance/scale weighing a small labelled sample, clearly marked "18 g"
> and "H₂O" (the H₂O subscript "2" must render as a true, smaller,
> lowered subscript — not the same size as the H and O). Visually
> connect this to the other side of the composition, which should show
> an artistic, dense, shimmering representation of an enormous number
> of particles — do not draw a small countable number of dots; use an
> artistic device that reads as "vast and uncountable by eye," such as
> a glowing particle cloud, a stream of light dissolving into
> countless points, or a stylised molecular pattern fading into
> abstraction. Label this side clearly: "1 mole" and, in correct
> scientific notation with a true raised superscript exponent,
> "6.02 × 10²³ molecules of H₂O" (use a genuine multiplication sign ×,
> not a lowercase x; the exponent "23" must be visibly smaller and
> raised above the baseline of "10").
>
> Do not include the phrase "Mr" or any relative-formula-mass
> calculation in this image — this figure is only about mass, the
> mole, and particle count.
>
> Do not state or imply that a mole is the same thing as one molecule
> or one particle — it must clearly read as a very large, fixed
> quantity of particles.
>
> Do not write "1 mole = 18 grams" as a general, unqualified statement
> — tie the 18 g figure specifically and visually to water/H₂O, not to
> "a mole" in general.
>
> Style: calm, precise, modern digital-textbook illustration quality —
> not cartoonish, not photorealistic, not generic AI-infographic art,
> not futuristic. Should look intentionally designed for a premium
> educational platform.
>
> Background: a soft, neutral, warm off-white or parchment tone — not
> stark white, not transparent. The image should read as a complete,
> self-contained illustration card.
>
> Aspect ratio: approximately 3:2 landscape.
>
> Double-check before finalising: is "H₂O" rendered with a true
> subscript 2? Is "10²³" rendered with a true superscript 23? Is the
> multiplication sign a real × symbol? Is "18 g" and "1 mole" both
> spelled correctly with no typos? Is it clear this represents a huge,
> uncountable quantity rather than a small counted set?

---

## HUMAN REVIEW CHECKLIST

- [ ] Scientific accuracy — 18 g, H₂O, 1 mole, 6.02 × 10²³ all correct
      and consistent with each other.
- [ ] Notation accuracy — H₂O subscript is a true subscript; 10²³ is a
      true superscript; × is a real multiplication sign, not "x".
- [ ] Spelling — every word (including "mole," "molecules," "water," any
      other embedded text) spelled correctly.
- [ ] Hierarchy — the mass↔mole↔particle-count story is the dominant
      visual read, not buried under text or competing detail.
- [ ] Legibility — all labels are clearly readable at the intended
      display size, not just at full generation resolution.
- [ ] Premium visual quality — reads as intentionally designed for
      Inspire, not generic stock/AI art.
- [ ] Pedagogical clarity — a learner who has just read Core Lesson
      Stage 2 would recognise this as illustrating exactly that
      paragraph, not something disconnected from it.
- [ ] No misleading geometry — the particle representation clearly
      reads as "vast/uncountable," not as a small exact set of
      countable objects.
- [ ] Worth the raster page weight — genuinely adds more to this
      specific lesson moment than a text paragraph alone, enough to
      justify the KB cost against the page's performance budget.

**If any answer is NO, regenerate rather than integrate.**

---

## HANDOFF AFTER APPROVAL

Once you've generated and approved a figure using the checklist above,
tell Claude:

> **"CHEM-QUANT-PFF-001 is approved. The final WebP is at
> `assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp`."**

(If you have the raw PNG/source instead and want Claude to do the WebP
conversion itself, say where the source file is instead, and Claude
will produce the optimised WebP at that same target path.)

At that point — and **not before** — Claude's job is limited to:

1. Verify the file exists at the stated path; inspect its actual
   dimensions, format, and file size against the targets above.
2. Convert/optimise to WebP if not already, resizing to the actual
   required display resolution, compressing to budget.
3. Integrate it into Core Lesson, immediately after Stage 2, with
   semantic `<figure>`/`<figcaption>`, the alt text and figcaption
   drafted above (refined as needed), and `loading="lazy"`.
4. Test responsive behaviour, theme framing (the card border/padding
   around the image, not the image's own internal content), file size,
   console/network errors, and layout overflow.
5. Preserve the current text-only Stage 2 as the de facto fallback —
   if this figure is rejected or needs rework, Stage 2 simply reads as
   it does today, with no visual, exactly as it does right now. Nothing
   about the lesson is at risk by requesting this.

**Claude will not recreate, redraw, or reconstruct any of the figure's
internal labels, arrows, or annotations.** If the approved image turns
out to contain a scientific or notational error at integration-time
review, the correct response is to reject/regenerate the asset, not to
patch it with an HTML/SVG overlay — that would silently turn this back
into Mode D without a decision to do so.

**None of steps 1–5 are performed by this request file.** This document
only specifies what's needed; it does not act on it.
