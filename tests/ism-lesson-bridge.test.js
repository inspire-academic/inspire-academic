// Runs the real assets/js/ism-lesson-bridge.js against a tiny fake DOM
// (no DOM library in this repo) to pin down how fields load and save.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const vm = require('vm');

const BRIDGE = fs.readFileSync(path.join(__dirname, '../assets/js/ism-lesson-bridge.js'), 'utf8');

function field(type, fieldId) {
  const listeners = {};
  return {
    nodeType: 1, type, value: type === 'checkbox' ? 'on' : '', checked: false, disabled: false,
    getAttribute: n => (n === 'data-save' ? fieldId : null),
    hasAttribute: n => n === 'data-save',
    setAttribute(n) { if (n === 'disabled') this.disabled = true; },
    addEventListener: (t, fn) => { (listeners[t] = listeners[t] || []).push(fn); },
    fire(t) { (listeners[t] || []).forEach(fn => fn()); }
  };
}

function runBridge(fields, config) {
  const posted = [];
  const docEvents = [];
  const document = {
    readyState: 'complete',
    documentElement: { scrollHeight: 100 },
    body: { scrollHeight: 100 },
    querySelectorAll: sel => (sel === '[data-save]' ? fields : []),
    addEventListener: () => {},
    dispatchEvent: e => docEvents.push(e.type)
  };
  const timers = [];
  const ctx = {
    window: { __ISM_CONFIG__: config, parent: { postMessage: m => posted.push(m) } },
    document,
    setTimeout: fn => { timers.push(fn); return timers.length; },
    clearTimeout: () => {},
    setInterval: () => 0,
    MutationObserver: function () { this.observe = () => {}; },
    CustomEvent: function (type) { this.type = type; },
    Number, Object, Math
  };
  vm.runInNewContext(BRIDGE, ctx);
  return { posted, docEvents, flush: () => timers.splice(0).forEach(fn => fn()) };
}

test('a ticked box saves "true" and an unticked box saves "" (not the checkbox value "on")', () => {
  const box = field('checkbox', 'w1_check_01');
  const { posted, flush } = runBridge([box], { responses: {}, readOnly: false });
  box.checked = true; box.fire('change'); flush();
  box.checked = false; box.fire('change'); flush();
  const saves = posted.filter(m => m.type === 'ism:save').map(m => m.value);
  assert.deepEqual(saves, ['true', '']);
});

test('saved ticks are restored as ticked; text answers restored as text', () => {
  const ticked = field('checkbox', 'c1');
  const unticked = field('checkbox', 'c2');
  const box = field('textarea', 'w1');
  runBridge([ticked, unticked, box], { responses: { c1: 'true', c2: '', w1: 'x = 3' }, readOnly: false });
  assert.equal(ticked.checked, true);
  assert.equal(unticked.checked, false);
  assert.equal(ticked.value, 'on', 'checkbox value is left alone');
  assert.equal(box.value, 'x = 3');
});

test('lesson is told once saved answers are in place (ism:hydrated), and read-only still locks fields', () => {
  const box = field('checkbox', 'c1');
  const { docEvents, posted } = runBridge([box], { responses: { c1: 'true' }, readOnly: true });
  assert.deepEqual(docEvents, ['ism:hydrated']);
  assert.equal(box.disabled, true);
  assert.ok(posted.some(m => m.type === 'ism:ready'));
});
