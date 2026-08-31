# Chemistry Production Benchmark — Electrolysis

## STATUS: HUMAN APPROVED / PUBLISHED / FROZEN

Electrolysis is the first genuinely new Chemistry lesson completed end to end
through the established Factory v0. The user approved both premium figures at
Gate 5 and the complete lesson at Gate 8 on 2026-08-31.

This freeze is a production reference, not a new factory architecture. Factory
v0 behaviour, the shared lesson engine, the four earlier frozen pilots, schemas
and the viewer remain unchanged.

## Frozen source set

Source content commit: `4ddaa5c16771d32c055292645580110033d6aac3`

| File | SHA-256 |
|---|---|
| `teaching-lessons/chemistry/chemical-changes-electrolysis.html` | `DE0780F8A2EC7687056D0CC8A0F75DDD381AAF6838A455665D15C2ED754119B8` |
| `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-001.webp` | `F40DC59BB5BFF51020B65DC37178B43D1CA104C0637FF85D60AB5233492CBB08` |
| `assets/images/chemistry/diagrams/electrolysis/CHEM-ELEC-PFF-002.webp` | `A8F75FB3B57B67B17DC15404DFDF84194678371EB96896446D4D13A013065D11` |

The associated manifest is
`docs/lesson-manifests/chemistry-electrolysis.md`; the complete gate record is
`docs/production/factory-runs/CHEMISTRY-PRODUCTION-RUN-001.md`.

## Approval evidence

- Gates 1–4: curriculum, science, pedagogy and assessment PASS.
- Gate 5: both premium figures HUMAN APPROVED scientifically and visually.
- Gate 6: programmatic accessibility and keyboard smoke checks PASS; no formal
  WCAG certification is claimed.
- Gate 7: standalone and authenticated external-Chrome staging viewer PASS.
- Gate 8: complete lesson HUMAN APPROVED on 2026-08-31.
- Automated baseline at Gate 8 integration commit `4f13224`: 350/350 PASS.
- Closeout verification with the freeze and rename control: 353/353 PASS.

## Canonical live identity

```text
title: Electrolysis
lessonsRowId: 032d728e-5eac-4604-9537-ebf218214f54
is_published: true
viewer_url: https://staging.inspireacademic.org/student/lesson-viewer.html?id=032d728e-5eac-4604-9537-ebf218214f54

legacyRowId: 82b58ab3-0246-44a5-bb2c-5c54a4b4efe5
legacy_is_published: false
legacy_retained_for_rollback: true
```

## Reopening rule

Do not edit the frozen source set for preference-driven polish. Reopen it only
for a genuine scientific or specification correction, an accessibility or
interaction defect, a rendering regression, an asset failure, or an explicitly
authorised platform migration. Any reopening must rerun the relevant gates and
update the manifest, factory-run record and hashes here.
