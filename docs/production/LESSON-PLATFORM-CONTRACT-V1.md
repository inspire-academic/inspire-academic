# Inspire Lesson Platform Contract v1

**Status:** active for new factory lessons; legacy lessons remain supported

## Decision

A lesson is durable educational content rendered through an upgradeable
platform. New factory lessons therefore expose a small versioned content
contract alongside their accessible HTML. The contract describes semantic
blocks and optional capabilities; it does not replace the proven HTML lesson
viewer, publication pipeline or Factory v0 gates.

## Stable block vocabulary

Contract v1 recognises:

```text
explanation
worked-example
question
diagram
assessment
simulation
```

Every block has a stable `id`, `order`, `type`, `learningGoal` and optional
`tier`. Presentation classes and DOM layout are not part of the content
contract. New lessons should also mark the rendered counterpart with
`data-ile-block` and `data-ile-block-type`, allowing future shared UI code to
enhance a block without parsing lesson prose or relying on visual class names.

## Optional capability seam

A simulation block is additive and provider-neutral. It declares:

- `componentId`: the platform capability requested;
- optional `provider`: provenance only, never the runtime dependency key;
- `inputs`: lesson-authored values/configuration;
- `learningGoal`: the educational purpose;
- `fallback`: meaningful text, static or diagram content;
- `accessibility`: label, description and optional keyboard instructions.

The runtime resolves only `componentId`. An adapter may be registered for that
identifier later. If it is absent or fails validation, the lesson presents the
declared non-interactive fallback. Lesson content never imports a named
simulation vendor directly.

## Versioning and compatibility

- `schemaVersion: 1` is required for contracted lessons.
- The v1 schema is immutable once lessons depend on it.
- A future v2 must ship an explicit v1→v2 migration before any v1 field is
  removed or reinterpreted.
- Lessons with no contract are treated as legacy v0: their existing standalone
  HTML continues to render unchanged. The platform contract is progressive
  enhancement, never a playback gate.
- Shared assets use versioned URLs. Compatible visual improvements may be made
  within v1 tokens; breaking token/component changes require a v2 asset.

## Shared UI seam

`assets/css/lesson-platform-tokens-v1.css` owns stable lesson-level typography,
spacing, radius, accent, focus and motion aliases. New lessons consume these
tokens and retain inline fallback values. This permits safe platform-wide UI
polish while ensuring a network failure or archived lesson still renders.

`assets/js/lesson-platform-contract-v1.js` provides validation and a minimal
adapter registry. It deliberately does not render the lesson, fetch content,
choose a simulation provider or create a plugin lifecycle.

## Factory requirements from Run 004 onward

1. Store lesson content/configuration as a v1 JSON contract and render matching
   semantic HTML blocks.
2. Validate the contract in the committed test suite.
3. Keep assessed content out of shared presentation code.
4. Require a meaningful fallback and accessibility metadata for every optional
   interactive block.
5. Do not retrofit frozen lessons merely to add metadata.

This is the minimum seam needed for future shared UI upgrades and simulations;
it is not authorisation for a CMS rewrite, a generic plugin framework or a new
publication architecture.
