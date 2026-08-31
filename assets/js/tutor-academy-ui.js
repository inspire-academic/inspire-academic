// tutor-academy-ui.js — shared render functions for Inspire Tutor
// Academy pages. Plain functions returning HTML strings, same
// zero-framework convention as the rest of the platform. No React —
// the build brief's component names are a conceptual guide, not a
// literal prescription (this repo has no build step).

function taEscHtml(str) {
  if (str === null || str === undefined) return ''
  return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')
}

function taRenderProgressBar(pct, opts) {
  opts = opts || {}
  const clamped = Math.max(0, Math.min(100, Math.round(pct || 0)))
  const height = opts.height || '8px'
  return `
  <div class="ta-progress-track" style="height:${height};">
    <div class="ta-progress-fill" style="width:${clamped}%;"></div>
  </div>${opts.showLabel ? `<div class="ta-progress-label">${clamped}% complete</div>` : ''}`
}

const TA_STAGE_META = {
  'biology-gcse-stage-1': { number: 1, title: 'Entry Diagnostic & Week 1', icon: '🔍' },
  'biology-gcse-stage-2': { number: 2, title: 'Specification Mastery', icon: '🧬' },
  'biology-gcse-stage-3': { number: 3, title: 'Examiner School', icon: '🎯' },
  'biology-gcse-stage-4': { number: 4, title: 'Practical & Mathematical Biology', icon: '🧪' }
}

function taRenderStageCard(stageId, status, progressPct) {
  const meta = TA_STAGE_META[stageId] || { number: '?', title: stageId, icon: '📘' }
  const locked = status === 'locked'
  const complete = status === 'complete'
  const statusLabel = locked ? 'Locked' : complete ? 'Complete' : progressPct > 0 ? 'In progress' : 'Not started'
  const statusClass = locked ? 'ta-status-locked' : complete ? 'ta-status-complete' : progressPct > 0 ? 'ta-status-active' : 'ta-status-pending'
  return `
  <div class="ta-stage-card ${locked ? 'ta-stage-card-locked' : ''}" ${locked ? '' : `onclick="window.location.href='stage-${meta.number}.html'"`}>
    <div class="ta-stage-card-num">${meta.icon}</div>
    <div class="ta-stage-card-body">
      <div class="ta-stage-card-title">Stage ${meta.number} — ${taEscHtml(meta.title)}</div>
      ${!locked ? taRenderProgressBar(progressPct) : `<div class="ta-progress-label">Complete Stage ${meta.number - 1} to unlock</div>`}
    </div>
    <span class="ta-stage-status ${statusClass}">${statusLabel}</span>
  </div>`
}

const TA_CERT_LABELS = {
  in_training: 'In Training',
  foundation_cleared: 'GCSE Foundation Cleared',
  provisionally_cleared: 'GCSE Biology Provisionally Cleared',
  cleared: 'GCSE Biology Cleared'
}

function taRenderCertificationStatus(status) {
  const label = TA_CERT_LABELS[status] || TA_CERT_LABELS.in_training
  return `<span class="ta-cert-badge ta-cert-${taEscHtml(status || 'in_training')}">${label}</span>`
}

// Expandable card for a Stage 2 domain's "Tutor Intelligence" —
// collapsed by default per the brief's "not 11 boxes at once on
// mobile." Shape follows IBTAEP Pack 02's actual domain structure: a
// concept-family/boundary-warning table, high-frequency misconceptions,
// and practical/maths/assessment links — not an invented field list.
function taRenderTutorIntelligenceCard(domain) {
  return `
  <div class="ta-domain-card">
    <button class="ta-domain-head" onclick="this.parentElement.classList.toggle('ta-open')">
      <span class="ta-domain-title">${taEscHtml(domain.title)}${domain.paper ? ` <span style="color:var(--muted);font-weight:400;font-size:.8rem;">(${taEscHtml(domain.paper)})</span>` : ''}</span>
      <span class="ta-domain-toggle">▾</span>
    </button>
    <div class="ta-domain-body">
      ${domain.scope ? `
        <div class="ta-domain-field">
          <div class="ta-domain-field-label">Domain scope</div>
          <div class="ta-domain-field-val">${taEscHtml(domain.scope)}</div>
        </div>` : ''}
      ${(domain.conceptFamilies || []).map(cf => `
        <div class="ta-domain-field">
          <div class="ta-domain-field-label">${taEscHtml(cf.family)}</div>
          <div class="ta-domain-field-val">${taEscHtml(cf.control)}</div>
          ${cf.boundary ? `<div class="ta-domain-field-val" style="color:var(--orange);margin-top:.2rem;">⚠ ${taEscHtml(cf.boundary)}</div>` : ''}
        </div>`).join('')}
      ${(domain.misconceptions && domain.misconceptions.length) ? `
        <div class="ta-domain-field">
          <div class="ta-domain-field-label">High-frequency misconceptions</div>
          <ul style="margin:.3rem 0 0 1.1rem;color:var(--muted);font-size:.88rem;line-height:1.6;">
            ${domain.misconceptions.map(m => `<li>${taEscHtml(m)}</li>`).join('')}
          </ul>
        </div>` : ''}
      ${domain.links ? `
        <div class="ta-domain-field">
          <div class="ta-domain-field-label">Practical / maths / assessment links</div>
          <div class="ta-domain-field-val">${taEscHtml(domain.links)}</div>
        </div>` : ''}
    </div>
  </div>`
}

const TA_ERROR_TAXONOMY = [
  { code: 'K', label: 'Knowledge', desc: 'The fact or process itself was not known or recalled.' },
  { code: 'M', label: 'Misconception', desc: 'A confidently held but incorrect model was applied.' },
  { code: 'A', label: 'Application', desc: 'The knowledge was known but not applied to this context.' },
  { code: 'Q', label: 'Question Interpretation', desc: 'The command word or question demand was misread.' },
  { code: 'L', label: 'Scientific Language', desc: 'Imprecise or non-technical vocabulary cost marks.' },
  { code: 'Math', label: 'Mathematical', desc: 'A calculation, unit, or numeracy skill broke down.' },
  { code: 'P', label: 'Practical Reasoning', desc: 'Variables, controls or method design reasoning was weak.' },
  { code: 'E', label: 'Exam Technique', desc: 'Timing, structure or answer length lost otherwise-available marks.' }
]

function taRenderErrorTaxonomy() {
  return `
  <div class="ta-taxonomy-grid">
    ${TA_ERROR_TAXONOMY.map(t => `
      <div class="ta-taxonomy-item">
        <span class="ta-taxonomy-code">${t.code}</span>
        <div>
          <div class="ta-taxonomy-label">${taEscHtml(t.label)}</div>
          <div class="ta-taxonomy-desc">${taEscHtml(t.desc)}</div>
        </div>
      </div>`).join('')}
  </div>`
}

const TA_CLEARANCE_OUTCOMES = [
  { key: 'cleared_supervised_deployment', label: 'Cleared — Supervised Deployment', tone: 'ta-outcome-good' },
  { key: 'cleared_with_conditions', label: 'Cleared — With Conditions', tone: 'ta-outcome-good' },
  { key: 'reassessment_required', label: 'Reassessment Required', tone: 'ta-outcome-warn' },
  { key: 'not_cleared', label: 'Not Cleared', tone: 'ta-outcome-bad' }
]

function taRenderClearanceBoard(selectedKey) {
  return `
  <div class="ta-clearance-board">
    ${TA_CLEARANCE_OUTCOMES.map(o => `
      <label class="ta-clearance-option ${o.tone} ${selectedKey === o.key ? 'ta-clearance-selected' : ''}">
        <input type="radio" name="ta-clearance-decision" value="${o.key}" ${selectedKey === o.key ? 'checked' : ''}>
        <span>${o.label}</span>
      </label>`).join('')}
  </div>`
}

if (typeof window !== 'undefined') {
  window.TutorAcademyUI = {
    escHtml: taEscHtml,
    renderProgressBar: taRenderProgressBar,
    renderStageCard: taRenderStageCard,
    renderCertificationStatus: taRenderCertificationStatus,
    renderTutorIntelligenceCard: taRenderTutorIntelligenceCard,
    renderErrorTaxonomy: taRenderErrorTaxonomy,
    renderClearanceBoard: taRenderClearanceBoard,
    STAGE_META: TA_STAGE_META,
    ERROR_TAXONOMY: TA_ERROR_TAXONOMY,
    CERT_LABELS: TA_CERT_LABELS
  }
}
if (typeof module !== 'undefined' && module.exports) {
  module.exports = {
    escHtml: taEscHtml,
    renderProgressBar: taRenderProgressBar,
    renderStageCard: taRenderStageCard,
    renderCertificationStatus: taRenderCertificationStatus,
    renderTutorIntelligenceCard: taRenderTutorIntelligenceCard,
    renderErrorTaxonomy: taRenderErrorTaxonomy,
    renderClearanceBoard: taRenderClearanceBoard,
    STAGE_META: TA_STAGE_META,
    ERROR_TAXONOMY: TA_ERROR_TAXONOMY,
    CERT_LABELS: TA_CERT_LABELS
  }
}
