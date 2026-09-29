# QA: "Energy Stores & Transfers" teaching board (Block 2 lesson candidate)

| | |
|---|---|
| Reviewed | 29 Sep 2026 |
| Reviewer | Physics Subject Expert Reviewer, independent Opus agent, read-only; checked against `content-standards/physics/`, `curriculum/physics/energy.js` and `docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md`; all 7 embedded diagrams extracted and inspected visually |
| Sources | `teaching-lessons/physics/inspire_physics_energy_stores_transfers_y10_final_sharp_premium.html` (7.1 MB) and `teaching-lessons/physics/Inspire_Physics_Energy_Stores-Transfers_Y10.html` (5.2 MB, v1) |
| Orchestrator spot-check of the reviewer | All confirmed: images 3 and 4 are byte-identical (md5 d96ff820…); image 3 shows "Particles (including air resistance)" as a pathway and "Light (radiation)" alongside "Heating (… radiation)"; image 5 shows "Sound energy 10–20%" for braking, "Thermal energy"/"Sound energy" as destinations, and the heat shimmer at the front bumper |
| **Verdict** | **NOT FIT.** The premium *text* is a sound base. Five of the seven diagrams and the inline Sankey teach errors the reference pack bans |

## Errors (must fix)

| # | Sev | Where | Problem | Correction |
|---|---|---|---|---|
| 1 | CRITICAL | Visual 6 inline SVG, kettle | "thermal store / water, kettle, air / useful output 90–95%"; waste = "sound 5–10%" only | Useful = thermal energy store of the **water**. Wasted = thermal stores of the kettle and surroundings (a little by sound). Use whole numbers (100 J → 85 J + 15 J), not ranges |
| 2 | CRITICAL | Visual 6 Sankey widths | Printed rule "width ∝ energy; useful + wasted = input" is broken: kettle ≈ 72:28 at the source; bulb's wasted flow is 10 px wide leaving and 78 px arriving | Redraw mathematically: constant flow widths, branch widths summing to the input |
| 3 | CRITICAL | Image 5 (Visual 4) and image 1 panel 3, braking Sankey | "10–20% Sound energy"; "Thermal energy"/"Sound energy" as stores; widths ≈ 60:40; heating drawn at the bumper | "Kinetic energy store of the car → thermal energy store of the brakes, tyres and surroundings (almost all); a very small amount by sound". Heating at the brake discs |
| 4 | CRITICAL | Image 3 (Visual 2) and image 1 panel 2 | "Particles (including air resistance)" as a pathway; radiation listed twice; "Light" as a pathway; all arrows point into an "ENERGY TRANSFER" hub | Use the four approved pathways: mechanically (work done by a force), electrically, by heating, by radiation. Delete "Particles" |
| 5 | MAJOR | Image 4 (Visual 3 "Transfer Chain System") | Byte-identical copy of image 3: the lesson contains no chain at all | Supply a real chain: chemical store (battery) → electrically → lamp → by radiation + by heating → thermal store of the surroundings |
| 6 | MAJOR | Image 6 (Visual 5) | "ENERGY TRANSFORMATION", "GPE is converted to KE" | "Energy is transferred from the gravitational potential energy store of the object–Earth system to the kinetic energy store of the object" |
| 7 | MAJOR | Image 1 (master overview) | "Electrical energy (input)", "Light energy", "Sound energy". It is also a screenshot of a mock UI (60 min vs 35 min, sections that don't exist, dead buttons) | Remove it, or rebuild with store/pathway language |
| 8 | MAJOR | Specification Mapping | Claims "calculate changes involving kinetic, elastic potential and gravitational potential energy"; the lesson has no equation and no calculation; omits 4.1.2.1, which it teaches most | Map to 4.1.1.1 (qualitative) and 4.1.2.1 (conservation, dissipation). Delete the calculation claim |
| 9 | MAJOR | Tier statement | Implies conservation/dissipation is Higher only | "Both tiers: conservation in a closed system and dissipation" |
| 10 | MAJOR | 6-mark task | Model answer is nearly word-for-word the Think answer shown minutes earlier: this tests copying. Levels have no mark bands or indicative content | Use a new context for the 6-marker; add banded levels (1–2 / 3–4 / 5–6) and indicative content |
| 11 | MAJOR | Edexcel mapping | "Topic 1 Energy" is wrong for Edexcel (Topic 1 is Key concepts); "8.10–8.11" and the quoted "mechanical processes become wasteful…" are **unverified** and probably belong to Edexcel Topic 3 | Check against the 1PH0/1SC0 specification before any school sees it |

## Minor issues (summary)

- Mixed "internal energy store" and "thermal energy store": standardise on "thermal energy store" (AQA 4.1).
- "Its kinetic store is approximately zero" → when the car stops, its kinetic energy is zero. The model answer never mentions the temperature rise of the brakes, which is the most creditable point.
- MCQ distractors are invented or implausible ("Nuclear transfer", "Energy is killed by friction"), none is mapped to the misconception library, and Q3's key is the one long technical option. Feedback is one generic "Not quite" per question.
- The unfinished Lesson Info panel reads "Template Lesson". Marketing captions ("Scientific Accuracy Hardened", "Sharp Premium") are false given errors 1–7.
- Diagram-standard non-compliance: raster images with serif type; decorative glows; all-caps labels; Sankeys neither to scale nor declared schematic; alt text is just the title; a thermometer represents the thermal store, which invites MIS-PHY-ENE-009.
- The images are upscaled crops of the overview, so they are soft when projected.

## Diagram verdicts

| Image | Content | Verdict |
|---|---|---|
| 1 | Master overview (UI mock-up, 6 panels) | NOT FIT: remove or rebuild |
| 2 | Energy stores grid | FIT AFTER CORRECTIONS (thermometer icon, "position" wording, field-line loops) |
| 3 | Pathways hub | NOT FIT |
| 4 | Duplicate of 3 | NOT FIT |
| 5 | Braking car + Sankey | NOT FIT (the before/during/after boxes are correct and can be kept) |
| 6 | Falling ball | FIT AFTER CORRECTIONS |
| 7 | Conservation balance | FIT |
| SVG | Kettle and bulb Sankeys | NOT FIT |

## Concept coverage (what the board actually teaches)

| Concept | Taught? |
|---|---|
| `phy.energy.stores-systems` | partial: stores named; system never defined; pathways content wrong |
| `phy.energy.conservation` | partial: correct closed-system statement; no worked context |
| `phy.energy.dissipation-efficiency` | partial: qualitative dissipation only; no efficiency |
| kinetic, gravitational, elastic, transfer-calcs, shc, power, resources, work-done | **none** |

## v1 vs premium

Keep the **premium text** as the canonical base. It fixes v1's forms-of-energy error and uses the AQA closed-system wording. Restore v1's "Teaching use" notes, strip the overclaims, and rebuild every defective image and the Sankey. **Archive v1.** Neither file is fit until the visuals are rebuilt. Both files are also 25–35× the page-weight budget.

## Consequence for School V1

The board can be a *starting resource* for Block 2's qualitative half (stores, pathways, conservation, dissipation) once the diagrams are rebuilt. It supplies nothing for work done, the calculations, SHC, power, efficiency or resources. Block 2 needs a new lesson that uses the premium text as source material. **It must not be shown to pupils in its current state.** It is also in the lessons pipeline, so check whether any pupil-facing route serves it today (`lessons` table / `student/lessons.html`).
