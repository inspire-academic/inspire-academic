# Inspire Electrolysis Cell Representation Family — v1

**Status:** REMEDIATED / TECHNICALLY VALIDATED / AWAITING HUMAN GATE 5 REVIEW.
The two explanatory SVGs have been replaced by scientifically validated Premium
Final Figures, and half-equation reasoning has been freshly routed to a native
HTML/typeset charge-audit card. Human visual approval remains pending, so none
of these representations is canonical yet.

Under the RATIFIED / ACTIVE **PREMIUM-FIRST SCIENCE REPRESENTATION POLICY**,
the old SVGs remain only in Git history as a record of the scientific and
pedagogical thinking they encoded. They were not polished or extracted into a
family. This remediation changed only the representation area and its supporting
styles/captions.

## Current remediated set

| Instance | Medium | Status |
|---|---|---|
| Molten lead bromide cell and charge pathways | Premium Final Figure `CHEM-ELEC-PFF-001` | Scientifically validated; human visual approval pending |
| Molten versus aqueous | Premium Final Figure `CHEM-ELEC-PFF-002` | Scientifically validated; human visual approval pending |
| Half-equation electron placement and charge balance | Native semantic HTML/typeset charge-audit card | Routing and notation technically validated; human visual approval pending |

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

## Three pre-remediation instances (historical)

| Instance | One sentence it must prove |
|---|---|
| Cell and charge pathways | Electrons travel through the external metal circuit while mobile cations and anions migrate through the electrolyte to oppositely charged electrodes. |
| Molten versus aqueous | Water adds H⁺ and OH⁻ competitors, so aqueous product prediction cannot be copied from the compound formula. |
| Electron-transfer strip | Cathode reduction places gained electrons on the left; anode oxidation places lost electrons on the right, with total charge balanced. |

## Historical temporary-SVG visual grammar

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

## Remediation result under Premium-First

1. **Premium rendered electrolysis cell implemented** — molten lead bromide,
   with cathode/anode polarity, Pb²⁺/Br⁻ migration, external electron flow,
   electrode products, redox labels and exact half-equations.
2. **Premium molten-versus-aqueous comparison implemented** — molten NaCl has
   only Na⁺/Cl⁻; aqueous NaCl also has water-derived H⁺/OH⁻ competitors and
   explicitly routes the learner to the selection rule without asserting
   products.
3. **Half-equation reasoning routed to native HTML/typesetting** — exact
   notation, atom audit and total-charge audit are selectable, responsive and
   accessible. Raster generation would add no pedagogical value and would make
   precision and accessibility worse.

No deterministic family should be extracted from the current SVGs. A future
deterministic representation would need a fresh, specific justification that
its geometry or data is itself instructional or assessed.

## Pre-remediation standalone live-QA result — 2026-08-24

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
outstanding. This historical SVG geometry result does not approve the new set.

## Remediation QA result — 2026-08-25

- Both source PNGs: 1536 × 1024.
- Integrated WebPs: 960 × 640; 42,906 bytes and 52,886 bytes.
- Combined representation raster weight: 95,792 bytes.
- Dark and Light themes: PASS.
- Higher and Foundation with Higher extensions: PASS.
- Desktop and true 390 px embedded viewport: PASS.
- 390 px document width: 375 px client / 375 px scroll; no horizontal overflow.
- Images loaded at 960 × 640 and rendered responsively at ~331 px wide in the
  mobile viewport.
- Full automated suite: 232/232 PASS.
- Alt text, real-text figcaptions, semantic `<figure>` markup, width/height and
  lazy loading: PASS.
- Figure 3 exact subscript/superscript notation and charge audits: PASS.

Gate 5 is **technically ready for human review**, not human approved. The
authenticated production blob/iframe still needs a post-deployment inspection.
