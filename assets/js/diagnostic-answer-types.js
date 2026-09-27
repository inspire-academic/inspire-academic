// Diagnostic answer types beyond multiple choice, for assessment-engine.html.
//
// A numeric question is answered by typing a number and, when the question
// has one, picking its unit from a list. The server marks it (see
// assets/js/diagnostic-numeric.js); nothing here knows the answer.
//
//   IADiagTypes.renderNumeric(container, question, onChange)
//     onChange({ chosen: 'x', answerText, answerUnit }) once something is
//     typed (and a unit picked, if the question has units);
//     onChange({ chosen: 'e' }) for "Not sure"; onChange(null) when cleared.
//   IADiagTypes.typedAnswerHtml(item, esc)
//     the review screen's "your answer / right answer" lines for one item.
(function () {
  'use strict';

  function el(tag, attrs, text) {
    const node = document.createElement(tag);
    Object.entries(attrs || {}).forEach(([k, v]) => node.setAttribute(k, v));
    if (text != null) node.textContent = text;
    return node;
  }

  function renderNumeric(container, q, onChange) {
    container.innerHTML = '';
    container.setAttribute('role', 'group');
    const units = Array.isArray(q.unit_options) ? q.unit_options : [];

    const row = el('div', { class: 'num-answer' });
    const input = el('input', {
      class: 'form-input num-input', id: 'num-input', type: 'text', inputmode: 'decimal', autocomplete: 'off',
      spellcheck: 'false', maxlength: '40', 'aria-label': 'Your answer (a number)', placeholder: 'Type your answer'
    });
    row.appendChild(input);

    let select = null;
    if (units.length) {
      select = el('select', { class: 'form-select num-unit', id: 'num-unit', 'aria-label': 'Unit' });
      select.appendChild(el('option', { value: '' }, 'Unit…'));
      units.forEach(u => select.appendChild(el('option', { value: u }, u)));
      row.appendChild(select);
    }
    container.appendChild(row);
    container.appendChild(el('p', { class: 'num-hint muted' },
      units.length ? 'Type the number, then choose its unit. You can write 3.2 × 10^4 as 3.2e4.'
                   : 'Type the number. You can write 3.2 × 10^4 as 3.2e4, and fractions as 1/9.'));

    const notSure = el('button', { type: 'button', class: 'mcq-option not-sure num-not-sure', 'aria-pressed': 'false' });
    notSure.innerHTML = '<div class="opt-label" aria-hidden="true">?</div><div class="opt-text">Not sure</div>';
    container.appendChild(notSure);

    function update() {
      notSure.classList.remove('selected');
      notSure.setAttribute('aria-pressed', 'false');
      const text = input.value.trim();
      const unit = select ? select.value : '';
      if (!text || (select && !unit)) return onChange(null);
      onChange({ chosen: 'x', answerText: text, answerUnit: unit || null });
    }
    input.addEventListener('input', update);
    if (select) select.addEventListener('change', update);
    notSure.addEventListener('click', () => {
      input.value = '';
      if (select) select.value = '';
      notSure.classList.add('selected');
      notSure.setAttribute('aria-pressed', 'true');
      onChange({ chosen: 'e' });
    });
    return { focus: () => input.focus() };
  }

  function typedAnswerHtml(r, esc) {
    const yours = r.not_sure ? 'Not sure' : [r.answer_text, r.answer_unit].filter(Boolean).join(' ');
    return `<ul class="review-opts">
      <li class="review-opt ${r.correct ? 'is-key' : 'is-chosen'}"><span>${esc(yours)} <span class="opt-tag">Your answer</span></span></li>
      ${r.correct ? '' : `<li class="review-opt is-key"><span>${esc(r.correct_value || '')} <span class="opt-tag">Right answer</span></span></li>`}
    </ul>`;
  }

  window.IADiagTypes = { renderNumeric, typedAnswerHtml };
})();
