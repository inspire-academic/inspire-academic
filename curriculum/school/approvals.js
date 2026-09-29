// Human approvals the School-Ready Gate relies on but cannot read from the
// repository. Only a person adds a row here, and only after doing the thing
// it records. An agent may transcribe an approval that Eric made in the live
// system (e.g. the block gate on teacher/question-review.html), citing where
// it is recorded; it may never create one.
//
// packs:  concept-pack blocks approved in the live database by
//         approve_content_block() (Eric's spot check + batch approval).
// gate:   manual gate items (end-to-end tests, delivery by a non-author,
//         data protection...), each with who verified it, when, and the
//         evidence. readiness.js treats a manual item as passed only if
//         it has an entry here.

const APPROVALS = {
  packs: {
    'phy-energy-kinetic-01': { by: 'Eric Appiah', date: '2026-09-28', evidence: 'Block approved on teacher/question-review.html#blocks after a 3-item spot check (all Pass); recorded in C:/InspireAcademic-Strategy/2026-09-28-status-and-eric-actions.md' },
    'phy-energy-gravitational-01': { by: 'Eric Appiah', date: '2026-09-28', evidence: 'Block approved on teacher/question-review.html#blocks after a 3-item spot check (all Pass); recorded in C:/InspireAcademic-Strategy/2026-09-28-status-and-eric-actions.md' }
  },
  gate: {}
};

module.exports = { APPROVALS };
