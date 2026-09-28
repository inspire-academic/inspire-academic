// Minimum evidence each concept pack must contain before it can go to review
// (docs/architecture/mastery-engine-production-architecture.md §1.3). The
// automated checks count a pack's items and templates against its concept's
// profile; a pack that falls short cannot pass.
//
// Counts are minimums. "diagnostic" may be met by an existing approved
// diagnostic item named in the pack's existingDiagnostics.
//   practiceTemplates   templates with evidence_class 'practice'
//   practiceFixed       fixed (non-template) practice items
//   practiceConceptual  fixed practice MCQs with no calculation
//   masteryCheck        mastery_check items; at least one at band >= 2, and at
//                       least one numeric or constructed when the concept's
//                       evidence.numeric is true
//   retrievalFixed      fixed retrieval items (calculation concepts get their
//                       retrieval from template instances)
const PROFILES = {
  calculation: { diagnostic: 1, practiceTemplates: 2, practiceFixed: 0, practiceConceptual: 1, masteryCheck: 2, retrievalFixed: 0 },
  mixed:       { diagnostic: 1, practiceTemplates: 1, practiceFixed: 0, practiceConceptual: 2, masteryCheck: 2, retrievalFixed: 1 },
  conceptual:  { diagnostic: 1, practiceTemplates: 0, practiceFixed: 4, practiceConceptual: 0, masteryCheck: 2, retrievalFixed: 1 },
  toolkit:     { diagnostic: 1, practiceTemplates: 2, practiceFixed: 0, practiceConceptual: 0, masteryCheck: 2, retrievalFixed: 0 }
};

const CONCEPT_PROFILE = {
  'phy.skills.units-prefixes': 'toolkit',
  'phy.skills.standard-form': 'toolkit',
  'phy.skills.rearranging': 'toolkit',
  'phy.skills.graph-reading': 'toolkit',
  'phy.energy.stores-systems': 'conceptual',
  'phy.energy.conservation': 'conceptual',
  'phy.energy.resources': 'conceptual',
  'phy.energy.kinetic': 'calculation',
  'phy.energy.gravitational': 'calculation',
  'phy.energy.elastic': 'calculation',
  'phy.energy.transfer-calcs': 'calculation',
  'phy.energy.shc': 'calculation',
  'phy.energy.power': 'calculation',
  'phy.energy.dissipation-efficiency': 'mixed',
  'phy.forces.work-done': 'calculation'
};

module.exports = { PROFILES, CONCEPT_PROFILE };
