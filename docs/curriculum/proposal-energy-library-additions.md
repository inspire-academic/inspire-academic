# Proposal: Energy library additions (for Eric's decision)

*28 September 2026 · status: PROPOSAL, nothing changed. The concept cards and misconception library in `curriculum/physics/energy.js` are approved content; nothing below goes in without your yes.*

The reviewer calibration (`docs/content-qa/calibration-energy-1.md`) listed two things to settle before the Energy packs. The kinetic and gravitational packs didn't need either. Power and the later packs do.

## 1. A shared "work done" concept

**Proposed card: `phy.forces.work-done`, Work done (W = Fs)**

| Field | Proposal |
|---|---|
| Objective | Recall and use W = Fs for a force acting along the direction of motion, and explain that work done is energy transferred (1 J = 1 N m) |
| Spec | AQA 4.5.2 (work done and energy transfer); 4.1.1.1 (energy transferred by work done) |
| Home domain | Forces; also in Energy (`domains: ['phy.forces', 'phy.energy']`) |
| Tier | Both |
| Prerequisites | rearranging (hard), units-prefixes (soft) |
| Required contexts | find-work, work-as-energy-transferred |
| Evidence | numeric yes, application yes, templated yes |
| Boundaries | Force along the line of motion only (no angles); work against friction dissipates energy to thermal stores |
| Misconceptions | new MIS-PHY-FOR-001 (below) |

**What it unlocks:**
- power items that start from a force and a distance (P = W/t with W = Fs);
- transfer-calculation items about work done against friction.

**If you'd rather wait:** the power pack can go ahead now using P = E/t, and P = W/t with the work done given in joules. Both equations are in the power card as it stands. Only "calculate the work, then the power" items need this concept.

**My recommendation: add it now.** Forces comes after Electricity in the ISM sequence and will need it anyway. Adding it now costs one card for you to review.

## 2. Misconception library additions

The calibration found nine gaps. For each I recommend one of:
- a **misconception**: recurring, and needing re-teaching or a method check. These go in the library with an id, and the engine can track them per student.
- a **named slip**: a one-off error. These stay as `slip: ...` text on the item, with no id and no tracking.

| Gap | Recommendation | Proposed entry |
|---|---|---|
| Adds a ½ to Ep (½mgh), by analogy with Ek | **Misconception** (procedural) | MIS-PHY-ENE-014: *Adds a factor ½ to Ep = mgh by analogy with Ek = ½mv².* Correct: Ep = mgh has no ½. Concepts: gravitational, transfer-calcs |
| Forgets to square the extension in Ee = ½ke² | **Misconception** (procedural) | MIS-PHY-ENE-015: *Does not square the extension in Ee = ½ke².* Mirrors ENE-004 for Ek. Concepts: elastic |
| Uses F = ke when the question asks for energy stored | **Misconception** (conceptual) | MIS-PHY-ENE-016: *Confuses the force stretching a spring with the energy stored in it.* Concepts: elastic |
| Thinks nuclear fuel is renewable | **Misconception** (conceptual) | MIS-PHY-ENE-017: *Classes nuclear fuel as renewable (because it is low-carbon or long-lasting).* Concepts: resources |
| Thinks a lubricant supplies energy | **Misconception** (conceptual) | MIS-PHY-ENE-018: *Thinks lubrication adds energy, rather than reducing the energy dissipated by friction.* Concepts: dissipation-efficiency |
| Thinks dissipated energy can be recovered or reused | **Misconception** (conceptual) | MIS-PHY-ENE-019: *Thinks energy dissipated to the surroundings can easily be recovered and used.* Concepts: dissipation-efficiency, conservation |
| Left out g | Named slip | — |
| Gave the wasted fraction instead of the efficiency | Named slip | — |
| Gave a decimal when a percentage was asked (or the reverse) | Named slip | — |
| (new, for work done) Uses a distance not along the force | **Misconception** (conceptual) | MIS-PHY-FOR-001: *Uses a distance that is not in the direction of the force (e.g. the horizontal distance when something is lifted).* Concepts: work-done |
| (from the gravitational review) Thinks the energy gained on lifting doesn't depend on mass, only on height | **Misconception** (conceptual) | MIS-PHY-ENE-020: *Thinks the gravitational potential energy gained depends only on the height, not the mass.* Concepts: gravitational |
| (from the gravitational review) Thinks lifting something faster stores more energy | **Extend MIS-PHY-ENE-011** (power vs energy) to cover gravitational and kinetic as well as power | ENE-011's concepts become power, gravitational, kinetic |

The last two came out of the gravitational review. Its reviewer noted that conceptual distractors in that pack had to fall back on ad-hoc "slip:" labels for these ideas.

## 3. One boundary to write down

Items that give a weight (Ep = weight × height, and the "weight used as mass" misconception MIS-PHY-ENE-007) assume students know weight = mg. That belongs to Forces (4.5.1.3), which comes later in the ISM sequence. It is also KS3 content. I propose adding this boundary to the gravitational card: *"Weight = mg is assumed from KS3; items may give a weight in newtons."* The alternative is to keep weight-based items out of Energy until Forces is taught. That would remove one approved mastery check (grav-mc-2).

**The rule I used:** a mistake becomes a library misconception when it recurs and points to a misunderstanding a teacher would re-teach. That is worth tracking per student. A one-step arithmetic or reading error stays a named slip. It still gets specific feedback on the item, but isn't tracked.

## What I need from you

- Work-done concept: **add now** / **wait**.
- Misconceptions: **approve the table as it stands**, or name any row to change.
- Weight boundary: **assume W = mg from KS3** / **keep weight items until Forces**.
- The power pack can start as soon as you answer. With "wait", it uses only E/t and a given W.
