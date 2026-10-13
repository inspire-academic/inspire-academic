// /api/v1/flashcards/approvals — public, read-only: which flashcards a
// teacher has approved (card id and fingerprint only). The logic lives with
// the review endpoint in flashcards-review.js.
exports.handler = require('./flashcards-review').approvalsHandler;
