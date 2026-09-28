// Teaching sequences, as data the Mastery Engine reads to know what has been
// taught (an untaught concept is "not yet taught", never "insecure") and to
// order new learning by the real timetable. Units list their concepts; a
// unit with no concepts yet is planned but not modelled. Planned dates are
// optional; actual teaching dates per cohort are recorded in the database
// (programme_unit_taught) by staff, not here.

const PROGRAMMES = [
  {
    id: 'ism-y10-physics',
    subject: 'Physics',
    units: [
      {
        id: 'ism-y10-physics.toolkit', name: "The Physicist's Toolkit",
        concepts: ['phy.skills.units-prefixes', 'phy.skills.standard-form', 'phy.skills.rearranging', 'phy.skills.graph-reading']
      },
      {
        id: 'ism-y10-physics.energy', name: 'Energy',
        concepts: ['phy.energy.stores-systems', 'phy.energy.conservation', 'phy.energy.kinetic', 'phy.energy.gravitational',
          'phy.energy.elastic', 'phy.energy.transfer-calcs', 'phy.energy.shc', 'phy.energy.power',
          'phy.energy.dissipation-efficiency', 'phy.energy.resources', 'phy.forces.work-done']
      },
      { id: 'ism-y10-physics.electricity', name: 'Electricity', concepts: [] }
    ]
  }
];

module.exports = { PROGRAMMES };
