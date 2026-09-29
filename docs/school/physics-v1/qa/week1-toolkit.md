# QA: ISM Physics Week 1 — The Physicist's Toolkit (Block 1 lesson candidate)

| | |
|---|---|
| Reviewed | 29 Sep 2026 |
| Reviewer | Physics Subject Expert Reviewer (`.claude/agents/physics-subject-reviewer.md`, run as an independent Opus agent, read-only, blind-solve first), against `content-standards/physics/` and `curriculum/physics/energy.js` at 5cbc45d |
| Sources | `~/Downloads/ISM_Physics_Week_1_Lesson_Class-V2.1.html` (student), `ISM_Physics_Week_1_Lesson_Class_Teacher.html`, `ISM_Physics_Week_1_Closing_Lesson_From_Situation_to_Solution.html`. None of them is in git. The live `ism_lesson_versions` row is the only record of which version pupils saw |
| Orchestrator spot-check of the reviewer | 5 findings checked against the source text and all confirmed: Q5 wording, Q14 contradiction, "same speed" conclusion, reveal buttons on the diagnostic (25 reveals in the file), prefix table without M/G/T. Also confirmed: the student reflection is saved to a field named `teacherDecision`, and the teacher file reuses the same field ids |
| **Verdict** | **NOT FIT** for school use as-is. Fit after the corrections below, plus a teacher guide and real graph-reading evidence |

## Verdict (reviewer)

Arithmetic is largely right: every numerical key recomputes. The lesson fails on three counts. The only energy-transfer model answer (Q5) uses forms-of-energy language the reference pack bans. Several stems and model answers would lose marks or teach misconceptions ("identical balls of different mass"; "same speed" from average speeds; "a force acts on a mass"). And the "teacher" file is the student page with four one-line captions changed: no mark schemes, homework answers, misconception notes or intervention guidance. Toolkit evidence is thin, repetitive and self-reported. As a *baseline*, 10 of its 15 diagnostic items are off-target for an Energy intervention (Forces, Waves, Electricity).

## Errors (must fix)

| # | Sev | Where | Text | Problem | Correction |
|---|---|---|---|---|---|
| 1 | CRITICAL | §2 Q5 (both files) | "Electrical energy is transferred to light and/or thermal energy pathways." | "Electrical energy" is not a store; "light/thermal energy pathways" confuses stores and pathways (MIS-PHY-ENE-002). Teaches the misconception. "State one … [2]" also mismatches the command word | "Energy is transferred electrically (by the current) from the chemical energy store of the battery to the lamp. The lamp transfers energy to the surroundings by light (radiation), which is useful, and by heating, which increases the thermal energy store of the lamp and the surroundings (dissipated)." Stem: "Describe the energy transfers when the lamp is switched on. [2]" |
| 2 | CRITICAL | §8 challenge | "the car travelled at the same speed in both parts" | Only average speeds are known | "…the car's **average** speed was the same (15 m/s) in both parts, so we cannot say it was faster in the first part." Stem: "Calculate the average speed…" |
| 3 | CRITICAL | §2 Q14 | "Two identical balls of different mass…" | Self-contradictory; release time not stated | "Two balls of the same size and shape but different masses are released from rest at the same time from the same height. Ignore air resistance…" Model: "Same time: with no air resistance the only force is weight, so both have the same acceleration, g, whatever their mass." |
| 4 | MAJOR | §2 Q8 | "A force of 12 N acts on a mass of 3 kg." | F = ma needs the **resultant** force; "acts on a mass" confuses object and mass | "The resultant force on an object of mass 3.0 kg is 12 N. Calculate the acceleration of the object. [2]" |
| 5 | MAJOR | §9 Exit Q3 | "Zero resultant force may involve balanced forces; no forces means none act at all." | "Explain" needs a reason; omits zero acceleration (the precise error class Inspire has flagged before) | "…In both cases the acceleration is zero, so a stationary object stays at rest and a moving object continues at constant velocity." |
| 6 | MAJOR | §3 key distinction | "Zero resultant force … It means the forces balance." | Correct but incomplete | Append: "Zero resultant force means zero acceleration: the object stays at rest or continues to move at constant velocity." |
| 7 | MAJOR | §4 prefixes | table lists k, c, m, µ, n only | Approved card requires T, G, M, k, c, m, µ, n; MJ/MW/GW are essential in Energy | Add tera, giga, mega; add g→kg and min/h→s to the drill |
| 8 | MAJOR | Week 1 §6 vs closing §04/§06 | Three routines: GIVEN–FIND–RELATIONSHIP–SUBSTITUTE–SOLVE–CHECK; Read–Extract–Model–Solve–Check; Known–Wanted–Relationship–Rearrange–Substitute–Answer | Three routines cannot be taught consistently | **Adopt one routine** programme-wide (see the programme manifest: `calculationRoutine`) |
| 9 | MAJOR | closing §02 | "A cyclist travels 180 m in 15 s. Do not calculate immediately…" | No question is asked | "What is the cyclist's average speed? Do not calculate yet: first complete Read, Extract and Model." |
| 10 | MAJOR | §2 Q7–Q9 | recall equations printed in the diagnostic | `equations.md`: recall equations are never printed in diagnostic items; the diagnostic cannot detect a recall failure | Remove them, or label them "Hint" and treat the items as scaffolded |
| 11 | MAJOR | §8 heading | "First Grade 9 Challenge" | One-step division, band 1 | Rename to "Challenge", or use the Problem of the Week (mean-of-speeds trap) |
| 12 | MAJOR | closing §05 Q7 | needs a = Δv/t and F = ma | Untaught; outside Energy and Toolkit | Replace with an Energy chain (Ep lost = Ek gained, or Ep then P = E/t) |

## Minor issues

1. Q13: "Forces may be acting" → forces definitely act (weight, normal contact, driving force, air resistance); add zero acceleration.
2. Q15 and homework B5: data with no quantity or unit ("Results for the time taken, in s: …"); model should exclude the anomaly from the mean (mean = 10.1 s); homework B5 has no model answer.
3. Standard form definition omits "n is an integer".
4. Graph answer: "Steeper straight section: greater speed (larger gradient). Horizontal: speed = 0."
5. Runner: constant speed not stated; "Decide" involves no decision.
6. Thousands separators: "240,000 J" → "240 000 J" (SI/AQA style).
7. Problem of the Week: "7.14 m/s (approx)" → "7.1 m/s (2 s.f.). Not (5 + 10) ÷ 2 = 7.5 m/s: the cyclist spends longer at the lower speed."
8. Homework A5 "Explain what zero resultant force means" → "Describe what zero resultant force means for the motion of an object."
9. Closing §01 Q2: the method mark is for the correct substitution, not the equation alone.
10. Closing §04 Q5: circular check → "80 W × 30 s = 2400 J ✓".
11. Closing §03 Q4: add "or the driving force could decrease to 300 N".
12. Closing §04 Q6: no command word → "Calculate the energy it transfers. [3]".
13. Closing: "PASCO" is not explained. Past papers may not be republished in a school product.
14. Baseline: Q6 (Waves), Q12 (Electricity RP), Q8, Q13, Q14 (Forces) are off-target for an Energy intervention.
15. Units table: note that s is both the symbol for distance and the unit symbol for seconds; add °C and m/s².

## Teacher-usability gaps

- No objectives or success criteria. No mark schemes for any 2-mark item: two teachers would score the 24-mark baseline differently. No answers for homework Parts A and B.
- No misconception guidance, hinge questions or "if most pupils fail X, do Y" routes. No threshold for "secure".
- Implausible timings: a 2-minute exit ticket with no marking time; 7-minute graph section with no graph; homework of ~12 short items timed at 35–45 min.
- **Evidence integrity:** "Reveal answer" is available to pupils during the diagnostic and the exit ticket, so neither is independent evidence.
- **Field ids:** the student's reflection is saved as `teacherDecision`, and `discussionNotes` is both a pupil reflection and a teacher observation field. Rename before any teacher input is ever read from these fields.
- No tier/differentiation guidance; Grade 8/9 framing throughout may not fit a school cohort that includes Foundation pupils.

## Evidence of mastery (per Toolkit concept)

| Concept | Assessment |
|---|---|
| `phy.skills.units-prefixes` | Weak and repetitive: kJ→J four times with new numbers; nothing on g→kg, min/h→s, M/G/T, or conversion inside a calculation. DEVELOPING at most |
| `phy.skills.standard-form` | Seven conversions, both directions: conversion fluency only; no use in a calculation; nothing at band ≥ 2 |
| `phy.skills.rearranging` | One exit item (E = Pt), one homework item; equations are printed for substitution. Insufficient |
| `phy.skills.graph-reading` | **No evidence.** No graph, no scale reading, no gradient. The 0–3 self-rating is self-report and must not certify anything |

## Consequence for School V1

Week 1 is a useful ISM *launch* lesson, but it is **not the Block 1 lesson**. Block 1 needs:

- a Toolkit repair lesson aimed at the four concepts, with real graph work and one calculation routine;
- concept-pack mastery checks for the four Toolkit concepts (not yet produced);
- a teacher guide.

The corrections above should still be applied to the live ISM lesson, because it is in use with pupils now. That is Eric's call, since the live version is not in git.
