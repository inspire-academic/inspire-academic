// Every figure a card or quiz question can carry, checked and drawn by kind:
//   'graph'                            assets/js/physics-graph.js
//   'diagram', 'structure', 'reaction' assets/js/chem-figure.js
//
//   Figures.check(figure, opts) -> [problems]
//   Figures.svg(figure, opts)   -> '<svg ...>' (or an <img> of a stored structure)
//
// opts is passed on to ChemFigure: { structures, structureSvg } (see there).
// In the browser, load physics-graph.js and chem-figure.js before this file.
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory(require('./physics-graph.js'), require('./chem-figure.js'));
  else root.Figures = factory(root.PhysicsGraph, root.ChemFigure);
})(typeof self !== 'undefined' ? self : this, function (PhysicsGraph, ChemFigure) {
  function isChem(fig) { return !!fig && ChemFigure.KINDS.indexOf(fig.kind) !== -1; }
  return {
    check: function (fig, opts) {
      if (isChem(fig)) return ChemFigure.check(fig, opts);
      if (fig && fig.kind === 'graph') return PhysicsGraph.check(fig);
      return ['a figure must have kind graph, diagram, structure or reaction'];
    },
    svg: function (fig, opts) { return isChem(fig) ? ChemFigure.svg(fig, opts) : PhysicsGraph.svg(fig); }
  };
});
