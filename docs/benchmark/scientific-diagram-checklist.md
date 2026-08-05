# Scientific Diagram Checklist (benchmark)

Applies to every inline `<svg>` diagram in an Inspire Learning
Experience lesson. Check each item before treating a diagram as done.

- [ ] **Physically accurate.** Arrow directions, relative magnitudes,
      and labelled quantities must be physically correct — not just
      visually plausible. For displacement diagrams specifically: the
      displacement arrow is always the straight line from start to
      end point, regardless of the path actually walked.
- [ ] **Every axis and arrow is labelled**, with units where
      applicable (m, not unlabelled numbers).
- [ ] **Scalar quantities are never drawn with a directional arrow.**
      Distance (a scalar) is shown as a path or accumulated length,
      never as a single vector arrow — this distinction is the entire
      point of the lesson and the diagrams must not undermine it.
- [ ] **Vector quantities always show both magnitude and direction**
      (arrow length and heading, or explicit +/- sign on a 1D number
      line).
- [ ] **Colour contrast passes in both Inspire Dark and Inspire
      Light** — check the diagram renders legibly under both
      `[data-theme="dark"]` and `[data-theme="light"]` token sets
      (use `currentColor` or CSS custom properties inside the SVG
      rather than hardcoded hex fills, so it inherits theme tokens).
- [ ] **No colour-only encoding.** Anything distinguished by colour
      (e.g. "outward" vs "return" leg of a journey) also carries a
      label, pattern, or arrowhead style difference.
- [ ] **Renders at 320px viewport width** without horizontal overflow
      or unreadably small text — check the SVG `viewBox` scales rather
      than fixed pixel dimensions.
- [ ] **No copied imagery.** Diagrams are original, hand-built SVG for
      this lesson — not sourced from textbooks, past papers, or
      external sites.
- [ ] **Captioned in text**, not only visually — a screen-reader user
      or a student on a very slow connection who can't render the SVG
      cleanly still gets the key relationship in words nearby.
