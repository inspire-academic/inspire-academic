// Under-13 parental consent on the sign-up paths (UK GDPR Art. 8 /
// DPA 2018 s.9: digital consent age is 13). Year 6–8 students may be
// under 13, so register.html requires parent details + explicit consent
// for Sci-Bridging Y6, Year 7 and Year 8, and index.html's quick sign-up
// (which has no consent step) hands those year groups to register.html.
// The pages' inline scripts are exercised against a minimal fake DOM.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { extractInlineScripts } = require('./helpers');

const REGISTER = fs.readFileSync(path.join(__dirname, '..', 'register.html'), 'utf8');
const INDEX = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');

function sliceFrom(src, startMarker, endMarker) {
  const start = src.indexOf(startMarker);
  assert.ok(start >= 0, `missing ${startMarker}`);
  const end = src.indexOf(endMarker, start);
  assert.ok(end > start, `missing ${endMarker} after ${startMarker}`);
  return src.slice(start, end);
}

// Runs register.html's consent-gate block (constant + both functions)
// with the year-group select set to `yearGroup`, returning each field's
// resulting state.
function runRegisterGate(yearGroup) {
  const script = extractInlineScripts(REGISTER).find(s => s.includes('updateParentRequirement'));
  assert.ok(script, 'register.html inline script with updateParentRequirement');
  const block = sliceFrom(script, 'const UNDER_13_YEAR_GROUPS', "document.getElementById('year-group').addEventListener");
  const els = {};
  const document = {
    getElementById: id => (els[id] = els[id] || { id, value: '', required: false, textContent: '', innerHTML: '', style: {} })
  };
  document.getElementById('year-group').value = yearGroup;
  new Function('document', `${block}\nupdateParentRequirement();`)(document);
  return els;
}

test('register.html: every year-group option value is covered by an explicit decision', () => {
  const values = [...REGISTER.matchAll(/<option value="([^"]+)">/g)].map(m => m[1]);
  for (const v of ['Sci-Bridging Y6', 'Y7', 'Y8', 'Y9']) {
    assert.ok(values.includes(v), `year-group select still offers ${v}`);
  }
});

for (const yearGroup of ['Sci-Bridging Y6', 'Y7', 'Y8']) {
  test(`register.html: ${yearGroup} requires parent details + consent (possibly under 13)`, () => {
    const els = runRegisterGate(yearGroup);
    assert.equal(els['year6-parent-consent'].required, true, 'consent checkbox required');
    assert.equal(els['year6-consent-group'].style.display, 'block', 'consent checkbox shown');
    for (const id of ['parent-first-name', 'parent-last-name', 'parent-email']) {
      assert.equal(els[id].required, true, `${id} required`);
    }
    assert.equal(els['parent-section-badge'].textContent, 'Required');
    assert.match(els['parent-info-box'].innerHTML, /Year 6–8 students may be under 13/);
  });
}

for (const yearGroup of ['Y9', 'Y10', 'Y11', 'A Level', 'Other', '']) {
  test(`register.html: ${yearGroup || '(no selection)'} keeps parent details optional`, () => {
    const els = runRegisterGate(yearGroup);
    assert.equal(els['year6-parent-consent'].required, false);
    assert.equal(els['year6-consent-group'].style.display, 'none');
    assert.equal(els['parent-email'].required, false);
    assert.equal(els['parent-section-badge'].textContent, 'Optional');
  });
}

test('register.html: submit handler re-checks the consent gate before creating the account', () => {
  const script = extractInlineScripts(REGISTER).find(s => s.includes('updateParentRequirement'));
  const guard = script.indexOf("isUnder13YearGroupSelected() &&");
  const signUp = script.indexOf('supa.auth.signUp(');
  assert.ok(guard > 0 && signUp > 0 && guard < signUp, 'consent re-check runs before supa.auth.signUp');
  assert.doesNotMatch(REGISTER, /only under-13 self-registration path/, 'stale "only under-13 path" copy removed');
});

test('index.html: quick sign-up sends Year 6–8 to register.html instead of creating an account', () => {
  const script = extractInlineScripts(INDEX).find(s => s.includes('function doSignup'));
  assert.ok(script, 'index.html inline script with doSignup');
  const block = sliceFrom(script, 'const UNDER_13_YEARS', 'function goStep2');
  const needsParentalConsent = new Function(`${block}\nreturn needsParentalConsent;`)();
  for (const y of ['Year 6', 'Year 7', 'Year 8']) assert.equal(needsParentalConsent(y), true, y);
  for (const y of ['Year 9', 'Year 10', 'Year 11', 'Year 12', '']) assert.equal(needsParentalConsent(y), false, y);
  // Every under-13 value must match an option the select actually offers.
  const options = [...sliceFrom(INDEX, '<select id="su-year">', '</select>').matchAll(/<option value="([^"]+)">/g)].map(m => m[1]);
  for (const y of ['Year 6', 'Year 7', 'Year 8']) assert.ok(options.includes(y), `su-year offers ${y}`);

  const goStep2 = sliceFrom(script, 'function goStep2', 'function goStep3');
  assert.match(goStep2, /if\(needsParentalConsent\(year\)\)\{sendToParentConsentSignup\(\);return;\}/);
  const doSignup = sliceFrom(script, 'async function doSignup', 'async function resetPw');
  const guard = doSignup.indexOf('needsParentalConsent(year)');
  assert.ok(guard > 0 && guard < doSignup.indexOf('supa.auth.signUp('), 'doSignup guards before signUp');
  assert.match(sliceFrom(script, 'function sendToParentConsentSignup', 'function goStep2'), /\/register\.html/);
});
