# Inspire Electrolysis Cell Representation Family — v1

**Status:** TEMPORARY / NON-CANONICAL. Scientific and standalone geometry QA
passed, but human review found that the three deterministic SVGs are not
exam-grade and do not meet the Inspire premium visual standard. Representation
Gate 5 is therefore not approved. Do not extract or reuse this family.

Under the RATIFIED / ACTIVE **PREMIUM-FIRST SCIENCE REPRESENTATION POLICY**,
these SVGs remain only as a record of the scientific and pedagogical thinking
they encode. They are not to be polished into canonical status merely because
they already exist. Replacement is separately authorised work; this policy
ratification does not alter the lesson HTML.

The production plan defined the purpose and routing of these representations
before lesson markup. This document records their exact family contract and QA
criteria; it does not create a generic Chemistry diagram system.

## Why existing families do not fit

- The Mass–Mole Strip family represents arithmetic composition and
  bidirectional quantitative relationships, not spatial migration or circuits.
- Physics vector/force families encode physical vectors whose length/direction
  carries magnitude; electrolysis migration arrows encode destination, not a
  vector quantity.
- Graph families are irrelevant because no continuous plotted relationship is
  being taught.

## Three temporary instances in the current lesson

| Instance | One sentence it must prove |
|---|---|
| Cell and charge pathways | Electrons travel through the external metal circuit while mobile cations and anions migrate through the electrolyte to oppositely charged electrodes. |
| Molten versus aqueous | Water adds H⁺ and OH⁻ competitors, so aqueous product prediction cannot be copied from the compound formula. |
| Electron-transfer strip | Cathode reduction places gained electrons on the left; anode oxidation places lost electrons on the right, with total charge balanced. |

## Visual grammar

- Cathode is always placed left and labelled `CATHODE (−)`; anode is right and
  labelled `ANODE (+)` in every cell instance.
- Cations and anions use distinct token-driven outlines plus visible charge
  notation; colour never carries sign alone.
- Ion-migration arrows terminate before electrodes and show destination only,
  never speed, force or electron flow.
- External electron paths are spatially separated above the electrolyte and
  use a distinct green token and explicit label.
- Result/decision boxes use the lesson's semantic gold emphasis; incorrect
  ideas use prose callouts, not ambiguous red particle symbols.
- All SVG text is at least 11 px in the 760-unit viewBox and the complete figure
  scales responsively without fixed CSS pixel dimensions.

## Scientific invariants

1. Cathode negative; anode positive for the electrolytic cell shown.
2. Cations migrate to cathode; anions migrate to anode.
3. Electrons are never drawn moving through the liquid.
4. Reduction is electron gain at cathode; oxidation is electron loss at anode.
5. Molten binary diagrams show only compound ions.
6. Aqueous diagrams explicitly include H⁺ and OH⁻ from water.
7. Half-equations conserve atoms and total charge.

## Accessibility and geometry

- Every SVG has unique `<title>` and `<desc>` nodes referenced by
  `aria-labelledby` and `aria-describedby`.
- Every relationship is restated in a real figcaption.
- Charge/direction meaning survives grayscale and colour removal through text,
  polarity symbols and arrow geometry.
- Required automated checks before live QA: duplicate IDs, SVG title/desc
  resolution, text bounds, text-vs-text intersections, and text-vs-line/arrow
  crossings where labels are not deliberately attached to the line.
- Live checks must cover both themes and a narrow viewport; source inspection
  cannot approve this family.

## Replacement direction under Premium-First

1. **Premium rendered electrolysis cell** — preferably the already-produced
   molten lead bromide reference direction. It must communicate cathode
   negative, anode positive, cation/anion migration, ionic conduction,
   external electron movement and electrode products at a glance.
2. **Premium rendered molten-versus-aqueous comparison** — compound ions only
   when molten; compound ions plus water-derived competitors when aqueous;
   discharge reasoning must become visually immediate.
3. **Half-equation reasoning** — do not automatically commission a third
   traditional diagram. Decide between a premium typeset reasoning figure, a
   native lesson card, or a premium rendered figure based on the clearest way
   to teach electron placement and charge checking.

No deterministic family should be extracted from the current SVGs. A future
deterministic representation would need a fresh, specific justification that
its geometry or data is itself instructional or assessed.

## Standalone live-QA result — 2026-08-24

- Dark and Light themes: PASS.
- Higher and Foundation, including Foundation + Higher extensions: PASS.
- Text bounds: 39/39 SVG text nodes inside their SVG bounds.
- Text-vs-text collisions: 0.
- Text-vs-line/path collisions: 0 after remediation.
- Duplicate rendered IDs: 0.
- Page horizontal overflow: 0 at desktop and 390 px viewport.
- Mobile: diagrams retain a 620 px internal reading surface inside a contained
  horizontal scroller; the page itself remains overflow-free.
- Representative token contrast, Light: 5.35:1 minimum; Dark: 10.31:1
  minimum across measured text/diagram semantic pairs.

One real geometry defect was found: the cathode/anode labels crossed the
vertical external wires. Both labels were moved into clear outer label zones
and the same text-vs-geometry check then returned zero collisions.

Production `student/lesson-viewer.html` blob/iframe verification remains
outstanding. More importantly, human representation review has explicitly not
approved the current visual set. Standalone technical QA does not override that
Gate 5 judgement.
