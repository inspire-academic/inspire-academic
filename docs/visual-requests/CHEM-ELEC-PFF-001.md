# Visual Request — CHEM-ELEC-PFF-001

**STATUS: HUMAN APPROVED / CANONICAL.** This request replaces
the temporary/noncanonical first Electrolysis SVG. The resulting asset must be
scientifically validated before integration and requires explicit human visual
approval before it can become canonical.

```yaml
id: CHEM-ELEC-PFF-001
status: human-approved-canonical
authoringMode: premium-final-figure
subject: GCSE Chemistry
topic: Electrolysis
lesson: Electrolysis
lessonFile: teaching-lessons/chemistry/chemical-changes-electrolysis.html
placement: "Representations, Figure 1"
tier: both
aspectRatio: "3:2 landscape"
targetAsset: assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-001.webp
targetDimensions: "960 × 640 px"
performanceBudget: "80 KB maximum; preserve label legibility"
humanApproval: approved-2026-08-31
```

## Pedagogical purpose

Make the two charge pathways in electrolysis immediately distinct while using
one concrete GCSE scenario: molten lead bromide. The learner should connect ion
migration in the electrolyte to electron transfer at the electrode surfaces and
electron flow in the external metal circuit.

## Three-second learner takeaway

Positive Pb²⁺ ions move to the negative cathode and are reduced to lead;
negative Br⁻ ions move to the positive anode and are oxidised to bromine.
Ions—not electrons—carry charge through the molten electrolyte.

## Exact scientific scenario

- An electrolytic cell containing molten lead bromide, PbBr₂(l).
- Two inert electrodes connected to a DC power supply.
- The cathode is negative; the anode is positive.
- Pb²⁺ migrates through the electrolyte towards the cathode.
- Br⁻ migrates through the electrolyte towards the anode.
- Electrons travel only through the external wires/electrodes: from the
  negative terminal to the cathode, and from the anode towards the positive
  terminal.
- Lead forms at the cathode; bromine, Br₂, forms at the anode.
- Reduction occurs at the cathode; oxidation occurs at the anode.

## Exact labels and notation

Render these verbatim and no others unless needed for a tiny key:

- `CATHODE (−)`
- `ANODE (+)`
- `molten PbBr₂`
- `Pb²⁺`
- `Br⁻`
- `ion flow in electrolyte`
- `electron flow in external circuit`
- `lead forms`
- `bromine forms`
- `reduction`
- `oxidation`
- `Pb²⁺ + 2e⁻ → Pb`
- `2Br⁻ → Br₂ + 2e⁻`

All 2 subscripts, 2+ superscripts and minus superscripts must be correctly
positioned. Use a true right arrow. Chemical equations must be reproduced
exactly.

## Arrow directions and required relationships

- Pb²⁺ arrow: through the molten electrolyte towards the cathode.
- Br⁻ arrow: through the molten electrolyte towards the anode.
- External electron arrows: negative supply terminal towards cathode; anode
  towards positive supply terminal.
- Never draw an electron-flow arrow across the electrolyte.
- Place the lead product and reduction equation beside the cathode.
- Place the bromine product and oxidation equation beside the anode.
- Use visually different arrow treatments for ion flow and electron flow, with
  an unobtrusive key or direct labels.

## Misconceptions to prevent

- Electrons cross the liquid electrolyte.
- Positive ions move to the positive electrode.
- The anode is negative in an electrolytic cell.
- Bromide forms monatomic bromine, Br, rather than Br₂.
- Oxidation occurs at the cathode or reduction at the anode.

## Forbidden or misleading content

- No electrons shown in the electrolyte.
- No reversed electrode signs, ion arrows or external electron arrows.
- No water, H⁺ or OH⁻: the electrolyte is molten, not aqueous.
- No product labels other than Pb and Br₂.
- No incorrect or simplified half-equations.
- No decorative laboratory clutter, people, mascots, glassware or generic
  infographic icons.

## Visual hierarchy and direction

1. The complete cell and the two distinct pathways.
2. Cathode/anode polarity and ion migration.
3. Products, redox labels and half-equations.

Use a calm, premium, professionally published GCSE textbook composition with
subtle dimensional depth, restrained callouts and generous whitespace. The
figure must remain diagrammatic and scientifically legible, not photorealistic,
cartoonish, futuristic or visually busy. Use Inspire navy, muted gold, warm
off-white and light-neutral accents. Keep any internal heading very restrained
because the page already supplies the section hierarchy.

## Framing, accessibility and performance

- Self-contained 3:2 landscape figure on a soft warm neutral background.
- Source generation should be at least 1536 × 1024 where supported.
- Final target: 960 × 640 WebP, responsive at `width:100%; height:auto`.
- Target asset path:
  `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-001.webp`.
- Maximum final size: 80 KB, unless human review explicitly accepts a small
  overage to protect essential notation legibility.
- Lazy-load below the fold.

**Alt text draft:** Premium educational diagram of electrolysis of molten lead
bromide. Pb²⁺ ions move through the electrolyte to the negative cathode, where
they gain electrons and form lead. Br⁻ ions move to the positive anode, where
they lose electrons and form bromine. Separate arrows show electrons moving
only through the external circuit.

**Figcaption draft:** In molten PbBr₂, Pb²⁺ migrates to the negative cathode and
is reduced to Pb, while Br⁻ migrates to the positive anode and is oxidised to
Br₂. Ions carry charge through the electrolyte; electrons travel through the
external wires and electrodes.

## Scientific verification checklist

- [x] Cathode is negative and anode is positive.
- [x] Pb²⁺ arrow points to the cathode.
- [x] Br⁻ arrow points to the anode.
- [x] External electron arrows point negative terminal → cathode and anode →
      positive terminal.
- [x] No electrons are shown travelling through the electrolyte.
- [x] Lead forms at the cathode; Br₂ forms at the anode.
- [x] `Pb²⁺ + 2e⁻ → Pb` is exact.
- [x] `2Br⁻ → Br₂ + 2e⁻` is exact.
- [x] Reduction and oxidation labels are assigned correctly.
- [x] Every label and charge/subscript is legible at final display size.

## Generation prompt

```text
Use case: scientific-educational
Asset type: complete final GCSE Chemistry lesson figure
Primary request: Create a premium educational figure showing electrolysis of molten lead bromide in one complete electrolytic cell. It must teach the difference between ion flow through the electrolyte and electron flow through the external circuit.
Scene/backdrop: self-contained diagram on a soft warm off-white/light-neutral background.
Subject: a restrained cutaway electrolytic cell containing molten PbBr₂, with two inert electrodes and a DC supply.
Style/medium: professionally published modern GCSE science textbook illustration; subtle dimensional depth; crisp diagrammatic callouts; calm and restrained.
Composition/framing: 3:2 landscape, central vessel, negative cathode on the left and positive anode on the right, external circuit clearly separated above, generous whitespace for labels.
Color palette: Inspire navy, muted gold, warm off-white, light neutral, with two clearly distinguishable but restrained arrow colours.
Text (verbatim): "CATHODE (−)", "ANODE (+)", "molten PbBr₂", "Pb²⁺", "Br⁻", "ion flow in electrolyte", "electron flow in external circuit", "lead forms", "bromine forms", "reduction", "oxidation", "Pb²⁺ + 2e⁻ → Pb", "2Br⁻ → Br₂ + 2e⁻".
Required arrows: Pb²⁺ through electrolyte towards cathode; Br⁻ through electrolyte towards anode; external electrons from negative terminal towards cathode and from anode towards positive terminal. Use different visual treatments for ion and electron arrows.
Constraints: exact scientific notation and equations; no electron arrows through liquid; no water ions; no extra products; no extra text; no title competing with the page heading; every label readable; no watermark.
Avoid: generic AI-infographic clutter, cartoon style, sci-fi styling, decorative apparatus, reversed arrows, reversed polarity, incorrect subscripts or superscripts.
```

## Human approval state

`APPROVED — 2026-08-31`. The user explicitly approved both Electrolysis
premium figures scientifically and visually for Gate 5. This approval makes
the figure canonical; it does not by itself complete lesson-level Gate 7 or
Gate 8.

## Generation and optimisation record

- Route: built-in OpenAI image generation (`scientific-educational`).
- First render rejected: positive-side external electron arrow pointed away
  from the power supply.
- Second render rejected: bromine resembled a metallic orange deposit.
- Accepted render: corrected external electron flow and red-brown bromine
  bubbles/vapour; all checklist items above independently rechecked.
- Raw review source: 1536 × 1024 PNG, retained outside the repository at
  `C:\Users\ericappiah\.codex\generated_images\01a032fd-5f75-7cd1-9cb5-d3d88f488712\exec-709c4214-7690-4b96-bac4-c649644e003b.png`.
- Integrated asset: 960 × 640 WebP, 42,906 bytes.
- Final asset path:
  `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-001.webp`.
