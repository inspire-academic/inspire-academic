# Physics subject review rubric (version 1)

Used by the Physics Subject Expert Review Agent on every item. Each criterion is scored PASS, FAIL or N/A; every FAIL carries a one-line reason.

## Procedure per item

1. **Blind solve.** Before reading the key, feedback, explanation or misconception mapping, answer the item as a strong GCSE student would, showing working. For templates, solve the stem symbolically and then three generated instances.
2. **Compare** your answer with the key.
3. **Score** every criterion below.
4. **Decide** using the decision rules.

## Criteria

| # | Criterion | Severity |
|---|---|---|
| A1 | Scientifically accurate (stem, key, feedback, explanation) | Hard |
| A2 | Blind-solve answer equals the key (numeric: within tolerance and unit) | Hard |
| A3 | Units correct and consistent; conversions stated or required as intended | Hard |
| A4 | Exactly one defensible answer; no second defensible option | Hard |
| A5 | No unintended clue (grammar, length, absolute words, stem words repeated in the key, option order) | Hard |
| B1 | Genuinely assesses the tagged primary concept, not mainly a secondary skill | Hard |
| B2 | Within the specification (`aqa-8463-energy.md` boundaries) and the taught sequence; no dependence on untaught material; recall vs given equations respected (`equations.md`) | Hard |
| B3 | Tier and difficulty band correct (`evidence-classes.md`) | Soft |
| B4 | Wording precise, unambiguous, GCSE reading level; terminology per `terminology.md` | Soft; Hard if the meaning changes |
| C1 | Each distractor is plausible and maps to an authentic misconception in the library or a named slip; none invented to fill a slot | Hard for mastery_check; Soft otherwise |
| C2 | Feedback for each wrong option names the likely mistake and the correct method | Soft |
| D1 | mastery_check: independent of practice items, no scaffolding, not a near-copy | Hard |
| D2 | retrieval: distinct form from original learning; short | Hard |
| D3 | application: unlabelled, requires transfer (multi-step or unfamiliar), not repetition | Hard |
| E1 | Marks match command word and demand (`command-words.md`) | Soft; Hard for application |
| E2 | Command word used correctly | Soft |
| F1 | Not a duplicate or near-duplicate of an existing item (see the check report; confirm) | Hard |
| F2 | Copyright: not a paraphrase of a past-paper question (see the similarity report; confirm) | Hard |
| G1 | Template valid across its whole parameter range; three instances solved; no instance where a mistake gives the correct answer | Hard |

## Decision rules

- **APPROVE:** no FAIL.
- **APPROVE_WITH_CORRECTIONS:** only Soft FAILs, each fixed by a stated surface edit that changes neither what is assessed nor the key. You write the exact replacement text. The corrected item is re-checked automatically and confirmed by you. Metadata re-tags count as surface edits **only in the safe direction**: lowering the difficulty band, widening the tier (Higher → Both) or moving an item down the evidence ladder (mastery_check → practice). A re-tag in the other direction would let a correction manufacture mastery evidence, so it is a REJECT.
- **REJECT:** any Hard FAIL, or any fix that would change the key, concept or content, or re-tag an item upwards (higher band, narrower tier, stronger evidence class). Say what is wrong; do not rewrite the item.

When in doubt between APPROVE_WITH_CORRECTIONS and REJECT, choose REJECT. Approving a defective mastery-check or application item is worse than rejecting a good one: those items certify a child's mastery.

## Report format

Return one JSON object, and nothing else:

```json
{
  "reviewer": "physics-subject-reviewer",
  "rubric_version": 1,
  "reference_pack_commit": "<git commit of content-standards/physics>",
  "block": "<block id>",
  "items": [
    {
      "item_ref": "<source:id or template id>",
      "blind_solve": "<your answer with brief working>",
      "key_matches": true,
      "criteria": { "A1": "PASS", "A2": "PASS", "B3": "FAIL: band 2 not 1 — requires g→kg conversion", "...": "..." },
      "decision": "APPROVE | APPROVE_WITH_CORRECTIONS | REJECT",
      "corrections": [ { "field": "question_text", "replace": "...", "with": "..." } ],
      "reason": "<one or two sentences; required unless APPROVE>"
    }
  ],
  "summary": { "approve": 0, "approve_with_corrections": 0, "reject": 0, "systematic_concerns": ["<patterns across items, if any>"] }
}
```
