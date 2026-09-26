# KaTeX 0.16.47 (self-hosted)

Typesets maths written as LaTeX between `\(` and `\)`. Loaded on demand by
`assets/js/maths-typeset.js`, and only on pages that have maths to show.

Copied from the `katex` npm package (`dist/`). MIT licence, see `LICENSE`.

One local change: only the `.woff2` fonts are shipped (every browser the
site supports reads woff2), so the `.woff` and `.ttf` fallbacks were removed
from each `@font-face` rule in `katex.min.css`.

The folder name carries the version, so these files never change in place
and can be cached forever. To upgrade, add a new `katex-<version>/` folder
and update `KATEX_BASE` in `assets/js/maths-typeset.js`.
