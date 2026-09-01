# Visual Request — CHEM-ATOM-PFF-001

```yaml
id: CHEM-ATOM-PFF-001
status: integrated-awaiting-human-approval
authoringMode: premium-final-figure
subject: Chemistry
topic: Atom Economy
lesson: Atom Economy
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-atom-economy.html
placement: Representations, before the coefficient calculation
tier: both
aspectRatio: "3:2"
targetAsset: assets/images/chemistry/diagrams/quantitative/CHEM-ATOM-PFF-001.webp
targetDimensions: "1200 × 800"
performanceBudget: "80 KB WebP maximum"
```

## Routing decision

No approved canonical asset explains atom economy through calcium carbonate
decomposition. The learner needs a memorable, realistic view of a tangible
starting material becoming a useful solid and a gaseous by-product. The exact
calculation remains real HTML text immediately below the figure, so the image
does not require machine-controlled geometry. Under the active Premium-First
policy this is Mode C, not SVG, graph or hybrid.

## Three-second learning purpose

The learner should immediately see that one reaction can split a fixed amount
of reactant mass between the product we want and a by-product, and that atom
economy measures the desired share.

## Exact scientific scenario

- Calcium carbonate decomposes on heating: CaCO₃ → CaO + CO₂.
- The starting calcium carbonate represents 100 relative mass units.
- Calcium oxide is the desired product and represents 56 mass units.
- Carbon dioxide is the by-product and represents 44 mass units.
- Mass is conserved: 100 = 56 + 44.
- Atom economy for calcium oxide is 56 ÷ 100 × 100 = 56%.

## Required visual content and labels

- A premium, realistic educational rendering of pale limestone/calcium
  carbonate entering a heated lime-kiln or controlled laboratory furnace.
- A clear left-to-right process flow to a pale quicklime/calcium oxide product
  and carbon dioxide visibly leaving as gas.
- Exact labels: “100 mass units CaCO₃”, “56 mass units CaO — desired product”,
  “44 mass units CO₂ — by-product”, and “56% atom economy”.
- Chemical formula numerals must be true, clearly legible subscripts.
- The desired-product route must dominate the hierarchy while the by-product
  remains unmistakable.

## Visual direction

Premium modern GCSE textbook illustration matching the established Inspire
Chemistry figure family: calm off-white/parchment background, deep navy labels,
restrained gold and green accents, realistic materials, subtle depth and
lighting, crisp professional composition. Scientifically credible rather than
cartoonish, cinematic, futuristic or stock-photographic. Avoid generic icons,
flat box diagrams, glowing sci-fi effects, decorative molecular clutter and
unlabelled arrows.

## Accessibility equivalent

Alt text and a real-text caption in the lesson will state the complete equation,
mass split and calculation. The raster is supplementary; no learner must read
image text to access the assessed information.

## Scientific and visual verification checklist

- [x] Equation and substances are correct.
- [x] 100 mass units split into exactly 56 desired and 44 by-product.
- [x] CaO is desired; CO₂ is by-product.
- [x] Every formula and subscript is correct.
- [x] Flow direction is unambiguous.
- [ ] Figure looks like a premium Inspire Chemistry publication.
- [x] Real-text accessibility equivalent is present.
- [x] Production WebP is no more than 80 KB.
- [ ] Human Gate 5 approval recorded before canonical status.

## Approval state

The previous deterministic SVG has been rejected by human visual review. This
replacement may be integrated for review but is not canonical until the user
explicitly approves it scientifically and visually at Gate 5.

## Generation and integration record

- Generated with the built-in OpenAI image-generation tool using the request
  contract above.
- First render rejected because of an unnecessary malformed explanatory line.
- Corrected render removes that line while preserving all required labels,
  values, formulae, arrows and apparatus.
- Production asset: `CHEM-ATOM-PFF-001.webp`, 1200 × 800, 62,172 bytes.
- Lesson contains no inline SVG after remediation.
- Real-text caption states the equation, 100 = 56 + 44 conservation and 56%
  atom-economy calculation.
- Automated repository suite: 425/425 PASS.
- Rendered desktop and exact 320px integration: PASS; no browser warnings or
  errors and no page-level horizontal overflow.
