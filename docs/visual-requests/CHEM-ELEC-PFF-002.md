# Visual Request — CHEM-ELEC-PFF-002

**STATUS: HUMAN APPROVED / CANONICAL.** This request replaces
the temporary/noncanonical second Electrolysis SVG. The resulting asset must be
scientifically validated before integration and requires explicit human visual
approval before it can become canonical.

```yaml
id: CHEM-ELEC-PFF-002
status: human-approved-canonical
authoringMode: premium-final-figure
subject: GCSE Chemistry
topic: Electrolysis
lesson: Electrolysis
lessonFile: teaching-lessons/chemistry/chemical-changes-electrolysis.html
placement: "Representations, Figure 2"
tier: both
aspectRatio: "3:2 landscape"
targetAsset: assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-002.webp
targetDimensions: "960 × 640 px"
performanceBudget: "80 KB maximum; preserve label legibility"
humanApproval: approved-2026-08-31
```

## Pedagogical purpose

Make the learner understand immediately why an aqueous electrolyte introduces
an additional product-selection decision. This is a conceptual comparison, not
a polished recreation of two boxes containing ions.

## Three-second learner takeaway

Molten sodium chloride contains only Na⁺ and Cl⁻. In aqueous sodium chloride,
water also supplies H⁺ and OH⁻, so ions compete for discharge at both
electrodes.

## Exact scientific scenario

A single left-to-right teaching composition contrasts:

- **Molten NaCl(l):** mobile Na⁺ and Cl⁻ ions from the compound only.
- **Aqueous NaCl(aq):** Na⁺ and Cl⁻ from the compound plus water-derived H⁺
  and OH⁻.
- The aqueous side introduces competing ions, so a GCSE product-selection rule
  must be applied; the figure must not itself predict products.

## Exact labels and notation

Render these verbatim and no additional product claims:

- `MOLTEN NaCl(l)`
- `compound ions only`
- `Na⁺`
- `Cl⁻`
- `AQUEOUS NaCl(aq)`
- `compound ions + ions from water`
- `H⁺`
- `OH⁻`
- `one ion family at each electrode`
- `competing ions — apply the selection rule`

Superscript charges and state symbols must be correct and legible.

## Required relationships

- Use one coherent visual transition from the molten state to the aqueous
  state, with water entering the conceptual model rather than two unrelated
  boxes.
- Keep Na⁺ and Cl⁻ visually consistent across both conditions.
- Introduce H⁺ and OH⁻ only on the aqueous side and visually associate them
  with water.
- Make the consequence—competition and the need for a selection rule—the
  dominant end point.

## Misconceptions to prevent

- Molten and aqueous electrolysis contain the same candidate ions.
- Water is chemically irrelevant in aqueous electrolysis.
- The salt formula alone determines aqueous products.
- Water replaces the compound ions rather than adding competitors.

## Forbidden or misleading content

- Do not state which products form from NaCl(aq); this figure establishes the
  candidates and decision need only.
- Do not imply that H⁺ and OH⁻ are present in molten NaCl.
- Do not omit Na⁺ or Cl⁻ from the aqueous side.
- Do not show free electrons moving through either electrolyte.
- Do not suggest literal large concentrations or quantitative ion ratios from
  the number of symbols drawn.
- No decorative laboratory clutter, generic icons or unrelated chemistry.

## Visual hierarchy and direction

1. Molten → aqueous conceptual transition.
2. Water adds H⁺/OH⁻ competitors.
3. Aqueous electrolysis therefore needs the selection rule.

Use a premium editorial teaching composition, visually calm and immediately
scannable, with purposeful depth and grouping rather than two flat boxes. Use
Inspire navy, muted gold, warm off-white and light-neutral colours. Keep
internal titling restrained because the lesson supplies the section heading.

## Framing, accessibility and performance

- Self-contained 3:2 landscape figure on a soft warm neutral background.
- Source generation should be at least 1536 × 1024 where supported.
- Final target: 960 × 640 WebP, responsive at `width:100%; height:auto`.
- Target asset path:
  `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-002.webp`.
- Maximum final size: 80 KB, unless human review explicitly accepts a small
  overage to protect essential notation legibility.
- Lazy-load below the fold.

**Alt text draft:** Premium educational comparison showing molten sodium
chloride containing only Na⁺ and Cl⁻ ions, while aqueous sodium chloride also
contains H⁺ and OH⁻ ions supplied by water, creating competing ions that require
a product-selection rule.

**Figcaption draft:** A molten ionic compound supplies only its own ions. In an
aqueous solution, water adds H⁺ and OH⁻ to the compound ions, so the possible
discharges compete and the aqueous selection rule must be applied.

## Scientific verification checklist

- [x] Molten side contains only Na⁺ and Cl⁻.
- [x] Aqueous side contains Na⁺, Cl⁻, H⁺ and OH⁻.
- [x] H⁺ and OH⁻ are clearly introduced by water only.
- [x] No products are asserted or implied.
- [x] No electrons are shown moving through either electrolyte.
- [x] State symbols and every superscript charge are correct.
- [x] Equal illustrative ion counts preserve electroneutrality without
      asserting concentration.
- [x] The need for the aqueous selection rule is visually obvious.

## Generation prompt

```text
Use case: scientific-educational
Asset type: complete final GCSE Chemistry lesson figure
Primary request: Create a premium conceptual comparison that makes clear why aqueous electrolysis needs an additional product-selection rule. Contrast molten sodium chloride with aqueous sodium chloride in one coherent left-to-right teaching composition, not two unrelated boxes.
Scene/backdrop: self-contained diagram on a soft warm off-white/light-neutral background.
Subject: on the molten side show only mobile Na⁺ and Cl⁻ ions. Transition through the addition of water to an aqueous side that retains Na⁺ and Cl⁻ and also introduces water-derived H⁺ and OH⁻, leading visually to competition and a selection-rule decision.
Style/medium: professionally published modern GCSE science textbook illustration; editorial, calm, restrained, with purposeful grouping and subtle dimensional depth.
Composition/framing: 3:2 landscape, clear left-to-right conceptual flow with generous whitespace and a strong final consequence.
Color palette: Inspire navy, muted gold, warm off-white, light neutral; consistent colours for each ion across the composition.
Text (verbatim): "MOLTEN NaCl(l)", "compound ions only", "Na⁺", "Cl⁻", "AQUEOUS NaCl(aq)", "compound ions + ions from water", "H⁺", "OH⁻", "one ion family at each electrode", "competing ions — apply the selection rule".
Constraints: exact superscript charges and state symbols; show H⁺ and OH⁻ only on the aqueous side; keep Na⁺ and Cl⁻ on both sides; do not predict any products; no electron flow; no extra text; no title competing with the page heading; no watermark.
Avoid: two plain boxes, generic AI-infographic clutter, cartoon styling, laboratory decoration, product claims, quantitative concentration implications, incorrect notation.
```

## Human approval state

`APPROVED — 2026-08-31`. The user explicitly approved both Electrolysis
premium figures scientifically and visually for Gate 5. This approval makes
the figure canonical; it does not by itself complete lesson-level Gate 7 or
Gate 8.

## Generation and optimisation record

- Route: built-in OpenAI image generation (`scientific-educational`).
- First render rejected: the molten side showed unequal Na⁺ and Cl⁻ symbol
  counts, potentially implying a non-neutral melt.
- Accepted render: three Na⁺ and three Cl⁻ symbols on the molten side; aqueous
  side retains Na⁺, Cl⁻, H⁺ and OH⁻ with no product claim.
- Raw review source: 1536 × 1024 PNG, retained outside the repository at
  `C:\Users\ericappiah\.codex\generated_images\01a032fd-5f75-7cd1-9cb5-d3d88f488712\exec-33658cb9-10f2-47b8-ad76-ca94332ec311.png`.
- Integrated asset: 960 × 640 WebP, 52,886 bytes.
- Combined lesson raster weight for the two figures: 95,792 bytes.
- Final asset path:
  `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-002.webp`.
