// core-topics.js — the curated topic cards each subject page actually
// shows in its "journey" UI (single source of truth for the COUNT).
//
// The `topics` Supabase table holds far more rows per subject than this —
// granular AQA sub-topics, exam-board naming variants, quiz-only anchors —
// which is why raw `topics` row counts (e.g. Physics: 22) don't match what
// a student can actually open and study (Physics: 8 cards). Each
// subjects/*.html page hardcodes its own TOPIC_SLUGS for that reason; this
// file exists so any other page (e.g. dashboard.html) that needs to show
// "how many topics are there" uses the same, accurate number.
//
// Keyed by subjects.id. Keep in sync with each subject page's TOPIC_SLUGS
// if a card is ever added or removed.
window.CORE_TOPICS = {
  1: ['number','algebra','sequences','ratio-proportion','geometry','trigonometry','probability','statistics'],           // Mathematics
  2: ['energy','electricity','particle-model','atomic-structure','forces-motion','waves','magnetism','space-physics'],   // Physics
  3: ['atomic-structure','bonding-structure','quantitative','chemical-changes','energy-changes','rates-equilibrium','organic-chemistry','chemical-analysis'], // Chemistry
  4: ['cell-biology','organisation','infection-response','bioenergetics','homeostasis','inheritance','evolution-ecology','key-concepts'] // Biology
}
