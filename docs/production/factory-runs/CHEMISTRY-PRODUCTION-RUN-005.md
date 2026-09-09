# Chemistry Production Run 005 — Concentration of Solutions

**Status:** PUBLISHED / GATES 1-8 PASS
**Branch:** `codex/chemistry-concentration-solutions`
**Authorised base:** `98d66cb72b2de45e0d981d30475721dac1401f84`

## Scope

This run follows Reacting Masses, Percentage Yield and Atom Economy by extending the same mole-and-unit discipline to solution concentration. It preserves Factory v0, Lesson Platform Contract v1 and Study UI v2 without architecture changes.

Included: g/dm³ for both tiers; cm³↔dm³ conversion; Higher mol/dm³, g/dm³↔mol/dm³ and simple reacting-volume concentration calculations. A full titration practical method is deferred to its dedicated practical lesson.

## Representation route

Premium Final Figure: realistic 100 mL versus 500 mL volumetric-flask comparison at equal solute mass, with assessed values in adjacent real text. Generated with the built-in ImageGen workflow using the `scientific-educational` route. No SVG is used.

## Planned gate state

| Gate | State |
|---|---|
| 1 Curriculum | PASS — official AQA and Pearson scope checked |
| 2 Academic | PASS — equations, unit conversions, calculations and tier boundary checked |
| 3 Assessment | PASS — contracted inventory and tier distinction delivered |
| 4 Build | PASS — v1 content contract mapped to shared Study UI shell |
| 5 Representation | PASS — human-approved premium realistic figure |
| 6 Accessibility | PASS — alt text, real-text equivalent and valid ARIA references |
| 7 Rendered QA | PASS — desktop and exact 320px; tier/mode/feedback interactions |
| 8 Human approval | PASS — publication authorised by the product owner |

Focused factory and lesson checks: **92/92 PASS**. Complete committed suite: **472/472 PASS**. The first dependency-free full run failed only because the fresh worktree had no `resend`/`sharp` modules; rerunning against the repository's existing installed dependency set passed completely.

Published from main commit `007f3b5e42dfa037c5e1d7dbbfc9aa87bdcbe18a` as lesson row `ca2fe8f1-c09a-429f-86ba-7ac62ac8b141`.
