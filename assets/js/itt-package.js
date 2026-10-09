// Inspire Test & Teach (ITT): the canonical quiz package, "itt.quiz.v1".
//
// A package is one JSON file written outside the platform (by ChatGPT, Claude
// or a person) that already holds everything: sections in teaching order,
// questions, the right answers, and a teaching explanation for every possible
// response. The platform imports it, shows it and records what students do.
// It never rewrites, reorders or regenerates the content.
//
// This file is the single place that knows the format:
//   validate(pkg)            every problem with a package, with its location
//   summarise(pkg)           counts for the teacher's import summary
//   publicPackage(pkg, ids)  what a student may see before answering: no
//                            answers, no feedback, no worked solutions
//   mark(question, response) deterministic marking, and which authored
//                            feedback belongs to that response
//   results(...)             a question's attempts, with their feedback
//   progress(...)            section, objective and mastery-check evidence
//
// Pure functions, no network. Shared: the Netlify functions require it, the
// teacher page loads it to check a file as soon as it is chosen and to run
// the preview, and the tests exercise it directly. The published contract is
// resources/itt/ITT_Quiz_Schema_v1.json; tests keep the two in step.
(function (root) {
  var numeric = (typeof module !== 'undefined' && module.exports) ? require('./diagnostic-numeric.js') : root.IANumeric;

  var SCHEMA = 'itt.quiz.v1';
  var QUESTION_TYPES = ['mcq', 'true_false', 'numeric', 'short_text'];
  var SECTION_TYPES = ['foundation', 'conceptual', 'practice', 'application', 'misconceptions', 'review', 'mastery'];
  var DIFFICULTIES = ['foundation', 'standard', 'challenge'];
  var PURPOSES = ['teach', 'practice', 'mastery'];
  var ASSET_TYPES = ['image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/svg+xml'];
  var TOLERANCE_TYPES = ['absolute', 'relative'];

  var LIMITS = {
    packageBytes: 4 * 1024 * 1024,
    assetBytes: 400 * 1024,
    assetsTotalBytes: 3 * 1024 * 1024,
    sections: 40,
    questions: 400,
    options: 6,
    retries: 3,
    marks: 20,
    title: 160,
    text: 6000,
    shortAnswer: 80,
    response: 200
  };

  var PACKAGE_ID_RE = /^[a-z0-9][a-z0-9-]{2,79}$/;
  var ID_RE = /^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$/;
  var OPTION_ID_RE = /^[A-Za-z0-9]{1,8}$/;
  var DATE_RE = /^\d{4}-\d{2}-\d{2}(T[\d:.]+(Z|[+-]\d{2}:\d{2})?)?$/;
  var EMAIL_RE = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/i;
  var HTML_TAG_RE = /<\/?(script|style|iframe|object|embed|img|svg|a|b|i|u|em|strong|br|p|div|span|sub|sup|table|tr|td|th|ul|ol|li|h[1-6]|font|code|pre)\b[^<>]*>/i;
  var FORBIDDEN_TEX_RE = /\\(href|url|includegraphics|htmlClass|htmlId|htmlStyle|htmlData|input|def|gdef|xdef|edef|let|newcommand|renewcommand|ce|pu)\b/;
  // Feedback that only says whether the answer was right teaches nothing.
  var VERDICT_RE = /^\s*(that('?s| is)\s+)?(correct|incorrect|right|wrong|yes|no|true|false|well done|good job|great|not quite|try again|exactly|nice work)\b[\s.!,:;–-]*/i;
  var NOT_SURE_TEXT_RE = /^\s*(i('|’)?m|i am)?\s*(not sure|unsure|don('|’)?t know|do not know)\b/i;
  var MIN_FEEDBACK_CHARS = 30;
  // The fields whose LaTeX is typeset. Every other text field is a label.
  var RICH_FIELDS = ['description', 'stem', 'text', 'feedback', 'teaching_note', 'worked_solution', 'misconception'];

  function isObject(v) { return v !== null && typeof v === 'object' && !Array.isArray(v); }
  function isText(v) { return typeof v === 'string' && v.trim().length > 0; }
  function has(o, k) { return Object.prototype.hasOwnProperty.call(o, k); }

  // ── Text ────────────────────────────────────────────────────────────
  // Authored text is plain text. Maths is LaTeX between \( and \) (inline)
  // or \[ and \] (on its own line). **bold** and blank-line paragraphs are
  // the only other formatting. Nothing is ever treated as HTML.

  // Splits text into [{ maths: false|'inline'|'block', text }]. Returns null
  // if a maths span is opened and never closed, or closed without opening.
  function splitMaths(text) {
    var parts = [], i = 0, s = String(text);
    while (i < s.length) {
      var a = s.indexOf('\\(', i), b = s.indexOf('\\[', i);
      var open = a === -1 ? b : (b === -1 ? a : Math.min(a, b));
      if (open === -1) break;
      var block = open === b && b !== -1 && (a === -1 || b < a);
      var close = s.indexOf(block ? '\\]' : '\\)', open + 2);
      if (close === -1) return null;
      if (open > i) parts.push({ maths: false, text: s.slice(i, open) });
      parts.push({ maths: block ? 'block' : 'inline', text: s.slice(open + 2, close) });
      i = close + 2;
    }
    if (i < s.length) parts.push({ maths: false, text: s.slice(i) });
    for (var k = 0; k < parts.length; k++) {
      if (!parts[k].maths && /\\\)|\\\]/.test(parts[k].text)) return null;
    }
    return parts;
  }

  function bracesBalanced(tex) {
    var depth = 0;
    for (var i = 0; i < tex.length; i++) {
      if (tex[i] === '\\') { i++; continue; }
      if (tex[i] === '{') depth++;
      else if (tex[i] === '}') { depth--; if (depth < 0) return false; }
    }
    return depth === 0;
  }

  // Problems with one piece of authored text, as [code, message] pairs.
  function textProblems(value) {
    var out = [];
    var s = String(value);
    // A LaTeX command written with one backslash in JSON is read as an
    // escape: "\frac" becomes a form feed and "rac", "\text" a tab and "ext".
    if (/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f\t\r]/.test(s.replace(/\r\n/g, '\n'))) {
      out.push(['lost_backslash', 'contains a control character. A LaTeX command has probably lost its backslash: in JSON write \\\\frac, \\\\text, \\\\times (two backslashes), not \\frac.']);
    }
    var parts = splitMaths(s);
    if (!parts) {
      out.push(['maths_delimiters', 'has a maths span that is not closed. Every \\( needs a matching \\) and every \\[ a matching \\].']);
      return out;
    }
    var plain = '';
    for (var i = 0; i < parts.length; i++) {
      var p = parts[i];
      if (!p.maths) { plain += p.text + ' '; continue; }
      if (!p.text.trim()) out.push(['maths_empty', 'has an empty maths span.']);
      if (/[\n\u000c\u0008]/.test(p.text) && p.maths === 'inline') {
        out.push(['lost_backslash', 'has a line break inside inline maths. A LaTeX command such as \\neq or \\nu has probably lost its backslash: write \\\\neq in JSON.']);
      }
      if (!bracesBalanced(p.text)) out.push(['maths_braces', 'has unbalanced { } in the maths "' + p.text.slice(0, 40) + '".']);
      var bad = FORBIDDEN_TEX_RE.exec(p.text);
      if (bad) {
        out.push(['maths_command', (bad[1] === 'ce' || bad[1] === 'pu')
          ? 'uses \\' + bad[1] + '{…}, which is not supported. Write chemistry with \\mathrm, e.g. \\(\\mathrm{Na^{+}}\\), \\(\\mathrm{H_2O}\\).'
          : 'uses the LaTeX command \\' + bad[1] + ', which is not allowed.']);
      }
    }
    if (HTML_TAG_RE.test(plain)) {
      out.push(['html_not_allowed', 'contains HTML (' + HTML_TAG_RE.exec(plain)[0] + '). HTML is never rendered: use plain text, **bold**, and LaTeX such as \\(\\mathrm{H_2O}\\) for subscripts.']);
    }
    if (EMAIL_RE.test(plain)) out.push(['personal_data', 'contains an email address. Packages must not hold personal information.']);
    return out;
  }

  // ── Notation that was probably meant to be typeset ──────────────────
  // The platform typesets only what is written as LaTeX; it never guesses
  // that a digit in a sentence is a subscript. So "Mg2+" or "Al2O3" typed as
  // plain text is shown exactly like that. These checks spot the common
  // cases and say so at import. They are notes, never errors: "KS3" and
  // "blood group O+" are not chemistry.
  var ELEMENTS = ('He Li Be Ne Na Mg Al Si Cl Ar Ca Sc Ti Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr Rb Sr Zr Ag Cd Sn Sb Te Xe Cs Ba Pt Au Hg Pb Bi ' +
    'H B C N O F P S K V Y I W U').split(' ');
  var EL = '(?:' + ELEMENTS.join('|') + ')';
  var UNIT = EL + '\\d{0,2}';
  var FORMULA_SRC = '((?:' + UNIT + '|\\((?:' + UNIT + ')+\\)\\d{1,2})+)';
  // A formula, then perhaps a charge: "Al2O3", "Ca(OH)2", "Mg2+", "Cl-".
  var NOTATION_RE = new RegExp('(^|[^A-Za-z0-9])' + FORMULA_SRC + '([+\\u2212-])?(?![A-Za-z0-9])', 'g');
  var EL_RE = new RegExp(EL, 'g');
  var ELEMENTAL = ['H2', 'N2', 'O2', 'F2', 'Cl2', 'Br2', 'I2', 'O3', 'S8', 'P4', 'C60'];
  var NOT_CHEMISTRY_RE = /^(KS[1-5]|Y\d+|H1N1|PS\d)$/;

  // "Mg2+" -> "\mathrm{Mg^{2+}}", "Al2O3" -> "\mathrm{Al_2O_3}". A guide for
  // the author, shown in the note; the package itself is never changed.
  function suggestTex(formula, sign) {
    var body = formula, charge = '';
    if (sign) {
      var s = sign === '+' ? '+' : '-';
      var count = (body.match(EL_RE) || []).length, tail = /(\d+)$/.exec(body);
      // One element, or two trailing digits: the last digit is the size of
      // the charge (Mg2+, SO42-). Otherwise it is a subscript (NH4+).
      if (tail && (count === 1 && body.indexOf('(') === -1 || tail[1].length === 2)) {
        charge = tail[1].slice(-1) + s;
        body = body.slice(0, -1);
      } else charge = s;
    }
    var tex = body.replace(/(\d+)/g, function (d) { return d.length > 1 ? '_{' + d + '}' : '_' + d; });
    if (charge) tex += charge.length > 1 ? '^{' + charge + '}' : '^' + charge;
    return '\\(\\mathrm{' + tex + '}\\)';
  }

  // Every piece of plain-text chemical notation in text that is outside maths.
  function plainNotation(plain) {
    var found = [], seen = {}, m;
    NOTATION_RE.lastIndex = 0;
    while ((m = NOTATION_RE.exec(plain))) {
      var formula = m[2], sign = m[3] || '', written = formula + sign;
      var count = (formula.match(EL_RE) || []).length, digits = /\d/.test(formula);
      if (NOT_CHEMISTRY_RE.test(formula)) continue;
      var isIon = false;
      if (sign === '+' || sign === '−') isIon = true;
      // A plain hyphen is usually just a hyphen: only "Cl-", "OH-", "O2-".
      else if (sign === '-') isIon = digits || formula.length > 1;
      var isFormula = digits && (count > 1 || formula.indexOf('(') !== -1 || ELEMENTAL.indexOf(formula) !== -1);
      if (!isIon && !isFormula) continue;
      if (!isIon) { written = formula; sign = ''; }
      if (!seen[written]) { seen[written] = true; found.push({ written: written, tex: suggestTex(formula, sign) }); }
    }
    return found;
  }

  // Roughly how many characters wide a piece of LaTeX is once typeset.
  function texWidth(tex) {
    return tex.replace(/\\(text|mathrm|mathbf|mathit|operatorname)\b/g, '').replace(/\\[A-Za-z]+/g, 'x').replace(/[{}^_\s\\]/g, '').length;
  }

  function textWarnings(value) {
    var out = [];
    var parts = splitMaths(String(value)) || [];
    var plain = parts.filter(function (p) { return !p.maths; }).map(function (p) { return p.text; }).join(' ');
    if (/\$[^$\n]{1,80}\$/.test(plain)) out.push(['dollar_maths', 'looks like maths written between $ signs, which is shown as plain text. Use \\( … \\).']);

    var notation = plainNotation(plain);
    if (notation.length) {
      var shown = notation.slice(0, 3);
      out.push(['plain_notation', 'has chemical notation typed as plain text (' + shown.map(function (n) { return '"' + n.written + '"'; }).join(', ') +
        (notation.length > 3 ? ' and ' + (notation.length - 3) + ' more' : '') + '), so its numbers and charges are shown on the line, not raised or lowered. Write it as LaTeX: ' +
        shown.map(function (n) { return n.tex; }).join(', ') + '. Ignore this note if it is not a formula.']);
    }
    var script = /[A-Za-z0-9)\]]\^\{?[-+]?[0-9A-Za-z]|[A-Za-z]_\{?[0-9]/.exec(plain);
    if (script) out.push(['plain_scripts', 'uses ^ or _ outside maths ("' + plain.slice(Math.max(0, script.index - 6), script.index + 8).trim() + '"), which is shown as typed. Put the expression between \\( and \\), e.g. \\(10^{3}\\), \\(\\mathrm{H_2O}\\).']);
    var unit = /(^|[^A-Za-z])((?:mm|cm|dm|km|m)[23])(?![A-Za-z0-9])/.exec(plain);
    if (unit) out.push(['plain_unit_power', 'has the unit "' + unit[2] + '" typed as plain text, so the power is not raised. Write \\(\\mathrm{' + unit[2].slice(0, -1) + '^' + unit[2].slice(-1) + '}\\).']);
    if (/[A-Za-z0-9)]\s?(-{1,2}>|=>)\s?[A-Za-z0-9(]/.test(plain)) out.push(['plain_arrow', 'has an arrow typed as "->". For a reaction arrow write the equation as maths with \\rightarrow, e.g. \\[2\\mathrm{Mg}+\\mathrm{O_2}\\rightarrow2\\mathrm{MgO}\\].']);

    parts.forEach(function (p) {
      if (p.maths === 'inline' && texWidth(p.text) > 28 && !out.some(function (w) { return w[0] === 'maths_wide'; })) {
        out.push(['maths_wide', 'has a long formula inside a sentence ("' + p.text.trim().slice(0, 40) + '…"). On a phone it will not fit on one line and has to be scrolled sideways. Put it on its own line with \\[ … \\].']);
      }
    });
    return out;
  }

  // Asks the real typesetter (KaTeX, when the caller has it) whether each
  // maths span can be displayed. Returns the first failure's message, or ''.
  var texChecked = {};
  function texProblem(engine, tex) {
    if (!engine || !engine.renderToString) return '';
    if (has(texChecked, tex)) return texChecked[tex];
    var problem = '';
    try { engine.renderToString(tex, { throwOnError: true, strict: 'ignore' }); }
    catch (e) { problem = String(e && e.message || e).replace(/^KaTeX parse error:\s*/, '').slice(0, 160); }
    texChecked[tex] = problem;
    return problem;
  }

  // The same kind of note can repeat hundreds of times in one file. Keep the
  // first few of each and say how many more there are.
  var CAPPED = { plain_notation: 25, plain_scripts: 10, plain_unit_power: 10, plain_arrow: 10, maths_wide: 15 };
  function capWarnings(warnings) {
    var counts = {}, out = [];
    warnings.forEach(function (w) {
      var cap = CAPPED[w.code];
      counts[w.code] = (counts[w.code] || 0) + 1;
      if (!cap || counts[w.code] <= cap) out.push(w);
    });
    Object.keys(CAPPED).forEach(function (code) {
      if (counts[code] > CAPPED[code]) {
        out.push({ code: code, path: '$', where: 'Whole file', message: 'The same note applies in ' + (counts[code] - CAPPED[code]) + ' more places (' + counts[code] + ' in all). Fix it throughout the file.' });
      }
    });
    return out;
  }

  // True when feedback explains something rather than only giving a verdict.
  function isInstructional(text) {
    if (!isText(text)) return false;
    var body = String(text).replace(VERDICT_RE, '').trim();
    return body.length >= MIN_FEEDBACK_CHARS;
  }

  // ── Validation ─────────────────────────────────────────────────────────
  function decodedLength(b64) {
    var clean = b64.replace(/=+$/, '');
    return Math.floor(clean.length * 3 / 4);
  }

  function decodeBase64(b64) {
    try {
      if (typeof atob === 'function') return atob(b64);
      return Buffer.from(b64, 'base64').toString('binary');
    } catch (e) { return null; }
  }

  // validate(pkg, { bytes }) -> { valid, errors, warnings, summary }
  // Each problem: { code, path, where, message }. `path` is the JSON path,
  // `where` says it in a teacher's words ("Section 2 “Ionic bonding” ›
  // Question 3 (s2-q03) › option B").
  function validate(pkg, opts) {
    var errors = [], warnings = [];
    // opts.katex: the KaTeX library, if the caller has it. With it, every
    // formula is test-typeset; without it, only its brackets are checked.
    var engine = (opts && opts.katex) || null;
    function err(code, path, where, message) { errors.push({ code: code, path: path, where: where, message: message }); }
    function warn(code, path, where, message) { warnings.push({ code: code, path: path, where: where, message: message }); }

    function unknown(obj, path, where, allowed) {
      Object.keys(obj).forEach(function (k) {
        if (allowed.indexOf(k) === -1) warn('unknown_field', path + '.' + k, where, 'The field "' + k + '" is not part of ' + SCHEMA + ' and is ignored.');
      });
    }

    function text(obj, key, path, where, o) {
      o = o || {};
      var v = obj[key], p = path + '.' + key, label = '"' + key + '"';
      if (v === undefined || v === null || v === '') {
        if (o.required) err('missing_field', p, where, label + ' is required.');
        return false;
      }
      if (typeof v !== 'string') { err('wrong_type', p, where, label + ' must be text.'); return false; }
      if (!v.trim()) { if (o.required) err('missing_field', p, where, label + ' is empty.'); return false; }
      if (v.length > (o.max || LIMITS.text)) err('too_long', p, where, label + ' is longer than ' + (o.max || LIMITS.text) + ' characters.');
      var problems = textProblems(v);
      problems.forEach(function (pr) { err(pr[0], p, where, label + ' ' + pr[1]); });
      // Notation notes only make sense where LaTeX is typeset. Labels such as
      // a title, an image's alt text or a unit are always plain text.
      var rich = !!o.rich || RICH_FIELDS.indexOf(key) !== -1;
      textWarnings(v).forEach(function (pr) {
        if (rich || !/^(plain_|maths_wide)/.test(pr[0])) warn(pr[0], p, where, label + ' ' + pr[1]);
      });
      // Only when the brackets and braces are sound is it worth asking the
      // typesetter; otherwise the problems above already say what is wrong.
      if (engine && !problems.some(function (pr) { return /^maths_|lost_backslash/.test(pr[0]); })) {
        (splitMaths(v) || []).some(function (part) {
          if (!part.maths) return false;
          var tex = part.maths === 'block' ? '\\displaystyle ' + part.text.trim() : part.text.trim();
          var problem = texProblem(engine, tex);
          if (problem) err('maths_invalid', p, where, label + ' has maths that cannot be typeset: "' + part.text.trim().slice(0, 60) + '" (' + problem + '). A student would see it as plain text.');
          return !!problem;
        });
      }
      if (!rich && /\\\(|\\\[/.test(v)) warn('maths_in_plain_field', p, where, label + ' contains LaTeX, but this field is always shown as plain text (titles, labels and image descriptions also appear in lists, links and screen readers). Write it in words or with ordinary characters.');
      return true;
    }

    // Teaching feedback: present, and more than a verdict.
    function feedback(obj, key, path, where, what) {
      var p = path + '.' + key;
      if (!isText(obj[key])) {
        err('missing_feedback', p, where, 'Teaching feedback is missing for ' + what + '. Every possible response needs its own explanation.');
        return;
      }
      if (!text(obj, key, path, where, { required: true, rich: true })) return;
      if (!isInstructional(obj[key])) {
        err('feedback_not_instructional', p, where, 'The feedback for ' + what + ' does not teach anything yet ("' + obj[key].trim().slice(0, 50) + '"). Explain the reasoning in at least a sentence.');
      }
    }

    function refs(list, key, path, where, known, what, o) {
      o = o || {};
      var v = list[key], p = path + '.' + key;
      if (v === undefined || v === null) {
        if (o.required) err('missing_field', p, where, '"' + key + '" is required: list at least one ' + what + ' id.');
        return [];
      }
      if (!Array.isArray(v)) { err('wrong_type', p, where, '"' + key + '" must be a list of ' + what + ' ids.'); return []; }
      if (o.required && !v.length) err('missing_field', p, where, '"' + key + '" must list at least one ' + what + ' id.');
      v.forEach(function (id, i) {
        if (typeof id !== 'string' || !known[id]) err('unknown_reference', p + '[' + i + ']', where, '"' + key + '" refers to ' + what + ' "' + id + '", which is not defined in this package.');
      });
      if (new Set(v).size !== v.length) err('duplicate_id', p, where, '"' + key + '" lists the same ' + what + ' twice.');
      return v;
    }

    function finish() {
      return { valid: errors.length === 0, errors: errors, warnings: capWarnings(warnings), summary: errors.length ? null : summarise(pkg) };
    }

    if (!isObject(pkg)) {
      err('not_an_object', '$', 'File', 'The file must contain one JSON object.');
      return finish();
    }
    if (pkg.schema !== SCHEMA) {
      err('unsupported_schema', '$.schema', 'File',
        pkg.schema === undefined ? '"schema" is missing. It must be "' + SCHEMA + '".'
          : 'Schema "' + String(pkg.schema).slice(0, 40) + '" is not supported. This importer accepts "' + SCHEMA + '".');
      return finish();
    }
    if (opts && opts.bytes > LIMITS.packageBytes) {
      err('too_large', '$', 'File', 'The file is larger than ' + (LIMITS.packageBytes / 1024 / 1024) + ' MB. Reduce or compress its images.');
    }
    unknown(pkg, '$', 'File', ['schema', 'package', 'objectives', 'topics', 'assets', 'settings', 'sections']);

    // ── package ──
    var meta = pkg.package;
    if (!isObject(meta)) {
      err('missing_field', '$.package', 'Package details', '"package" is required: the title, subject, year group and other details.');
      meta = {};
    } else {
      var W = 'Package details';
      unknown(meta, '$.package', W, ['id', 'title', 'description', 'subject', 'year_group', 'exam_board', 'tier', 'specification', 'author', 'created', 'content_version', 'estimated_minutes']);
      if (typeof meta.id !== 'string' || !PACKAGE_ID_RE.test(meta.id)) {
        err('invalid_id', '$.package.id', W, '"id" must be a lower-case identifier of 3 to 80 letters, digits and hyphens, e.g. "y10-chem-structure-bonding". It stays the same across versions of this package.');
      }
      text(meta, 'title', '$.package', W, { required: true, max: LIMITS.title });
      text(meta, 'description', '$.package', W, { required: true });
      text(meta, 'subject', '$.package', W, { required: true, max: 60 });
      text(meta, 'year_group', '$.package', W, { required: true, max: 40 });
      text(meta, 'exam_board', '$.package', W, { max: 60 });
      text(meta, 'tier', '$.package', W, { max: 40 });
      text(meta, 'specification', '$.package', W, { max: 300 });
      text(meta, 'content_version', '$.package', W, { required: true, max: 40 });
      if (typeof meta.created !== 'string' || !DATE_RE.test(meta.created) || isNaN(Date.parse(meta.created))) {
        err('invalid_date', '$.package.created', W, '"created" must be a date such as "2026-10-08".');
      }
      if (!isObject(meta.author)) err('missing_field', '$.package.author', W, '"author" is required, e.g. { "source": "ChatGPT" }.');
      else {
        unknown(meta.author, '$.package.author', W, ['source', 'model', 'notes']);
        text(meta.author, 'source', '$.package.author', W, { required: true, max: 80 });
        text(meta.author, 'model', '$.package.author', W, { max: 80 });
        text(meta.author, 'notes', '$.package.author', W, { max: 600 });
      }
      if (meta.estimated_minutes !== undefined && !(Number.isInteger(meta.estimated_minutes) && meta.estimated_minutes > 0 && meta.estimated_minutes <= 3000)) {
        err('invalid_number', '$.package.estimated_minutes', W, '"estimated_minutes" must be a whole number of minutes.');
      }
    }

    // ── objectives and topics ──
    function catalogue(key, what, fields, textKey) {
      var known = {}, list = pkg[key], W2 = what.charAt(0).toUpperCase() + what.slice(1) + 's';
      if (!Array.isArray(list) || !list.length) {
        err('missing_field', '$.' + key, W2, '"' + key + '" is required: list at least one ' + what + '.');
        return known;
      }
      list.forEach(function (item, i) {
        var p = '$.' + key + '[' + i + ']', w = W2 + ' › item ' + (i + 1);
        if (!isObject(item)) { err('wrong_type', p, w, 'Each ' + what + ' must be an object with an "id".'); return; }
        unknown(item, p, w, fields);
        if (typeof item.id !== 'string' || !ID_RE.test(item.id)) err('invalid_id', p + '.id', w, 'Each ' + what + ' needs a short "id" (letters, digits, . _ -).');
        else if (known[item.id]) err('duplicate_id', p + '.id', w, 'The ' + what + ' id "' + item.id + '" is used more than once.');
        else known[item.id] = item;
        text(item, textKey, p, w, { required: true, max: 600 });
        if (fields.indexOf('description') !== -1) text(item, 'description', p, w, { max: 1200 });
      });
      return known;
    }
    var objectives = catalogue('objectives', 'objective', ['id', 'text'], 'text');
    var topics = catalogue('topics', 'topic', ['id', 'title', 'description'], 'title');

    // ── assets ──
    var assets = {}, assetUse = {}, assetBytes = 0;
    if (pkg.assets !== undefined) {
      if (!Array.isArray(pkg.assets)) err('wrong_type', '$.assets', 'Images', '"assets" must be a list.');
      else pkg.assets.forEach(function (a, i) {
        var p = '$.assets[' + i + ']', w = 'Images › item ' + (i + 1) + (a && a.id ? ' (' + a.id + ')' : '');
        if (!isObject(a)) { err('wrong_type', p, w, 'Each asset must be an object.'); return; }
        unknown(a, p, w, ['id', 'media_type', 'data', 'alt', 'caption']);
        if (typeof a.id !== 'string' || !ID_RE.test(a.id)) err('invalid_id', p + '.id', w, 'Each asset needs a short "id".');
        else if (assets[a.id]) err('duplicate_id', p + '.id', w, 'The asset id "' + a.id + '" is used more than once.');
        else assets[a.id] = a;
        if (ASSET_TYPES.indexOf(a.media_type) === -1) err('unsupported_asset', p + '.media_type', w, '"media_type" must be one of: ' + ASSET_TYPES.join(', ') + '.');
        if (!text(a, 'alt', p, w, { required: true, max: 600 })) { /* reported by text() */ }
        text(a, 'caption', p, w, { max: 600 });
        if (typeof a.data !== 'string' || !a.data.length) err('missing_field', p + '.data', w, '"data" is required: the image, base64-encoded.');
        else if (!/^[A-Za-z0-9+/]+={0,2}$/.test(a.data) || a.data.length % 4 !== 0) err('invalid_asset', p + '.data', w, '"data" is not valid base64. Give the image bytes only, without a "data:" prefix.');
        else {
          var size = decodedLength(a.data);
          assetBytes += size;
          if (size > LIMITS.assetBytes) err('asset_too_large', p + '.data', w, 'This image is ' + Math.round(size / 1024) + ' KB. The limit is ' + (LIMITS.assetBytes / 1024) + ' KB per image.');
          if (a.media_type === 'image/svg+xml') {
            var svg = decodeBase64(a.data) || '';
            if (/<script|<foreignObject|\son\w+\s*=|javascript:|<iframe|<embed|<object/i.test(svg)) {
              err('unsafe_asset', p + '.data', w, 'This SVG contains script or embedded content, which is not allowed.');
            }
          }
        }
      });
      if (assetBytes > LIMITS.assetsTotalBytes) err('asset_too_large', '$.assets', 'Images', 'The images total ' + Math.round(assetBytes / 1024) + ' KB. The limit for one package is ' + (LIMITS.assetsTotalBytes / 1024) + ' KB.');
    }
    function assetRefs(obj, path, where) {
      refs(obj, 'asset_ids', path, where, assets, 'image').forEach(function (id) { assetUse[id] = true; });
    }

    // ── settings ──
    function retriesField(obj, path, where) {
      if (obj.retries === undefined) return;
      if (!(Number.isInteger(obj.retries) && obj.retries >= 0 && obj.retries <= LIMITS.retries)) {
        err('invalid_number', path + '.retries', where, '"retries" must be a whole number from 0 to ' + LIMITS.retries + ': how many times a student may try a question again after feedback.');
      }
    }
    if (pkg.settings !== undefined) {
      if (!isObject(pkg.settings)) err('wrong_type', '$.settings', 'Settings', '"settings" must be an object.');
      else { unknown(pkg.settings, '$.settings', 'Settings', ['retries']); retriesField(pkg.settings, '$.settings', 'Settings'); }
    }

    // ── sections and questions ──
    var sectionIds = {}, questionIds = {}, questionCount = 0;
    if (!Array.isArray(pkg.sections) || !pkg.sections.length) {
      err('missing_field', '$.sections', 'Sections', '"sections" is required: a package needs at least one section.');
      return finish();
    }
    if (pkg.sections.length > LIMITS.sections) err('too_many', '$.sections', 'Sections', 'A package may have at most ' + LIMITS.sections + ' sections.');

    pkg.sections.forEach(function (s, si) {
      var sp = '$.sections[' + si + ']';
      var sw = 'Section ' + (si + 1) + (isObject(s) && isText(s.title) ? ' “' + s.title.trim().slice(0, 60) + '”' : '');
      if (!isObject(s)) { err('wrong_type', sp, sw, 'Each section must be an object.'); return; }
      unknown(s, sp, sw, ['id', 'title', 'description', 'type', 'purpose', 'estimated_minutes', 'topic_ids', 'objective_ids', 'requires', 'retries', 'questions']);

      var validId = typeof s.id === 'string' && ID_RE.test(s.id);
      if (!validId) err('invalid_id', sp + '.id', sw, 'Each section needs a short, stable "id" (letters, digits, . _ -), e.g. "s1".');
      else if (sectionIds[s.id]) err('duplicate_id', sp + '.id', sw, 'The section id "' + s.id + '" is used more than once. Section ids must be unique.');

      text(s, 'title', sp, sw, { required: true, max: LIMITS.title });
      text(s, 'description', sp, sw, { required: true });
      text(s, 'purpose', sp, sw, { required: true, max: 600 });
      if (SECTION_TYPES.indexOf(s.type) === -1) err('invalid_value', sp + '.type', sw, '"type" must be one of: ' + SECTION_TYPES.join(', ') + '.');
      if (s.estimated_minutes !== undefined && !(Number.isInteger(s.estimated_minutes) && s.estimated_minutes > 0 && s.estimated_minutes <= 600)) {
        err('invalid_number', sp + '.estimated_minutes', sw, '"estimated_minutes" must be a whole number of minutes.');
      }
      refs(s, 'topic_ids', sp, sw, topics, 'topic', { required: true });
      refs(s, 'objective_ids', sp, sw, objectives, 'objective', { required: true });
      retriesField(s, sp, sw);
      var mastery = s.type === 'mastery';
      if (mastery && s.retries) err('mastery_retries', sp + '.retries', sw, 'A mastery section cannot allow retries: it measures what the student can do unaided, first time.');

      // A section may only wait for sections that come before it, so the
      // order in the file is always a possible order to work in.
      if (s.requires !== undefined) {
        if (!Array.isArray(s.requires)) err('wrong_type', sp + '.requires', sw, '"requires" must be a list of earlier section ids.');
        else s.requires.forEach(function (id, i) {
          if (!sectionIds[id]) err('invalid_prerequisite', sp + '.requires[' + i + ']', sw, '"requires" names section "' + id + '", which is not an earlier section in this package. A section can only depend on sections that come before it.');
        });
      }
      if (validId) sectionIds[s.id] = true;

      if (!Array.isArray(s.questions) || !s.questions.length) {
        err('missing_field', sp + '.questions', sw, 'This section has no questions. Each section needs at least one.');
        return;
      }
      s.questions.forEach(function (q, qi) {
        var qp = sp + '.questions[' + qi + ']';
        var qw = sw + ' › Question ' + (qi + 1) + (isObject(q) && typeof q.id === 'string' ? ' (' + q.id.slice(0, 40) + ')' : '');
        questionCount++;
        if (!isObject(q)) { err('wrong_type', qp, qw, 'Each question must be an object.'); return; }

        if (typeof q.id !== 'string' || !ID_RE.test(q.id)) err('invalid_id', qp + '.id', qw, 'Each question needs a short, stable "id" (letters, digits, . _ -), e.g. "s1-q01".');
        else if (questionIds[q.id]) err('duplicate_id', qp + '.id', qw, 'The question id "' + q.id + '" is used more than once. Question ids must be unique across the whole package.');
        else questionIds[q.id] = true;

        if (QUESTION_TYPES.indexOf(q.type) === -1) {
          err('unsupported_question_type', qp + '.type', qw, 'Question type "' + String(q.type).slice(0, 40) + '" is not supported. Supported types: ' + QUESTION_TYPES.join(', ') + '.');
          return;
        }
        var common = ['id', 'type', 'stem', 'marks', 'difficulty', 'purpose', 'topic_ids', 'objective_ids', 'asset_ids', 'not_sure', 'teaching_note', 'worked_solution', 'answer', 'feedback'];
        var own = { mcq: ['options'], true_false: [], numeric: ['wrong_answers'], short_text: ['wrong_answers'] }[q.type];
        unknown(q, qp, qw, common.concat(own));

        text(q, 'stem', qp, qw, { required: true });
        if (!(Number.isInteger(q.marks) && q.marks >= 1 && q.marks <= LIMITS.marks)) err('invalid_marks', qp + '.marks', qw, '"marks" must be a whole number from 1 to ' + LIMITS.marks + '.');
        if (DIFFICULTIES.indexOf(q.difficulty) === -1) err('invalid_value', qp + '.difficulty', qw, '"difficulty" must be one of: ' + DIFFICULTIES.join(', ') + '.');
        if (q.purpose !== undefined && PURPOSES.indexOf(q.purpose) === -1) err('invalid_value', qp + '.purpose', qw, '"purpose" must be one of: ' + PURPOSES.join(', ') + '.');
        else if (q.purpose === 'mastery' && !mastery) err('mastery_outside_mastery_section', qp + '.purpose', qw, 'A mastery question must sit in a section whose "type" is "mastery", so students can tell a mastery check from teaching questions.');
        else if (q.purpose !== undefined && q.purpose !== 'mastery' && mastery) err('mastery_outside_mastery_section', qp + '.purpose', qw, 'Every question in a mastery section is a mastery question. Remove "purpose" or set it to "mastery".');
        refs(q, 'objective_ids', qp, qw, objectives, 'objective', { required: true });
        refs(q, 'topic_ids', qp, qw, topics, 'topic');
        assetRefs(q, qp, qw);
        text(q, 'teaching_note', qp, qw);
        text(q, 'worked_solution', qp, qw);

        if (!isObject(q.not_sure)) err('missing_feedback', qp + '.not_sure', qw, 'Teaching feedback is missing for the “I’m not sure” response. Add "not_sure": { "feedback": "…" }.');
        else { unknown(q.not_sure, qp + '.not_sure', qw, ['feedback']); feedback(q.not_sure, 'feedback', qp + '.not_sure', qw, 'the “I’m not sure” response'); }

        if (q.type === 'mcq') checkMcq(q, qp, qw);
        else if (q.type === 'true_false') checkTrueFalse(q, qp, qw);
        else if (q.type === 'numeric') checkNumeric(q, qp, qw);
        else checkShortText(q, qp, qw);
      });
    });
    if (questionCount > LIMITS.questions) err('too_many', '$.sections', 'Sections', 'A package may have at most ' + LIMITS.questions + ' questions; this one has ' + questionCount + '.');

    function checkMcq(q, qp, qw) {
      if (q.feedback !== undefined) warn('unknown_field', qp + '.feedback', qw, 'A multiple-choice question keeps its feedback on each option; the question-level "feedback" is ignored.');
      if (!Array.isArray(q.options) || q.options.length < 2) { err('missing_field', qp + '.options', qw, 'A multiple-choice question needs at least 2 options.'); return; }
      if (q.options.length > LIMITS.options) err('too_many', qp + '.options', qw, 'A multiple-choice question may have at most ' + LIMITS.options + ' options (the “I’m not sure” response is added by the platform).');
      var ids = {}, texts = {};
      q.options.forEach(function (o, oi) {
        var op = qp + '.options[' + oi + ']';
        var ow = qw + ' › option ' + (isObject(o) && typeof o.id === 'string' ? o.id.slice(0, 8) : oi + 1);
        if (!isObject(o)) { err('wrong_type', op, ow, 'Each option must be an object.'); return; }
        ['correct', 'is_correct', 'isCorrect'].forEach(function (k) {
          if (has(o, k)) err('correct_flag', op + '.' + k, ow, 'Do not mark the right option with "' + k + '". Give the id of the one correct option in the question\'s "answer" field.');
        });
        unknown(o, op, ow, ['id', 'text', 'feedback', 'misconception', 'correct', 'is_correct', 'isCorrect']);
        if (typeof o.id !== 'string' || !OPTION_ID_RE.test(o.id)) err('invalid_id', op + '.id', ow, 'Each option needs a short "id" of letters or digits, e.g. "A".');
        else if (ids[o.id]) err('duplicate_id', op + '.id', ow, 'The option id "' + o.id + '" is used twice in this question.');
        else ids[o.id] = true;
        if (text(o, 'text', op, ow, { required: true, max: 1200 })) {
          var t = o.text.trim().toLowerCase();
          if (texts[t]) err('duplicate_option', op + '.text', ow, 'Two options have the same text.');
          texts[t] = true;
          if (NOT_SURE_TEXT_RE.test(o.text)) err('not_sure_option', op + '.text', ow, 'Do not add “I’m not sure” as an option. The platform offers it on every question; put its explanation in "not_sure".');
        }
        feedback(o, 'feedback', op, ow, 'option ' + (typeof o.id === 'string' ? o.id.slice(0, 8) : oi + 1));
        text(o, 'misconception', op, ow, { max: 200 });
      });
      if (typeof q.answer !== 'string' || !q.answer) err('missing_answer', qp + '.answer', qw, '"answer" is required: the id of the one correct option, e.g. "B".');
      else if (!ids[q.answer]) err('invalid_answer', qp + '.answer', qw, '"answer" is "' + q.answer.slice(0, 20) + '", which is not the id of any option in this question.');
      else q.options.forEach(function (o, oi) {
        if (isObject(o) && o.id === q.answer && isText(o.misconception)) warn('misconception_on_answer', qp + '.options[' + oi + '].misconception', qw, 'The correct option has a "misconception" label, which is ignored.');
      });
    }

    function pairFeedback(q, qp, qw, keys, labels) {
      if (!isObject(q.feedback)) {
        err('missing_feedback', qp + '.feedback', qw, 'Teaching feedback is missing. Add "feedback" with ' + keys.map(function (k) { return '"' + k + '"'; }).join(' and ') + '.');
        return;
      }
      unknown(q.feedback, qp + '.feedback', qw, keys);
      keys.forEach(function (k, i) { feedback(q.feedback, k, qp + '.feedback', qw, labels[i]); });
    }

    function checkTrueFalse(q, qp, qw) {
      if (typeof q.answer !== 'boolean') err('missing_answer', qp + '.answer', qw, '"answer" must be true or false (without quotes).');
      pairFeedback(q, qp, qw, ['true', 'false'], ['the answer “True”', 'the answer “False”']);
    }

    function wrongAnswers(q, qp, qw, check) {
      if (q.wrong_answers === undefined) return;
      if (!Array.isArray(q.wrong_answers)) { err('wrong_type', qp + '.wrong_answers', qw, '"wrong_answers" must be a list.'); return; }
      q.wrong_answers.forEach(function (w, wi) {
        var wp = qp + '.wrong_answers[' + wi + ']', ww = qw + ' › wrong answer ' + (wi + 1);
        if (!isObject(w)) { err('wrong_type', wp, ww, 'Each wrong answer must be an object.'); return; }
        check(w, wp, ww);
        feedback(w, 'feedback', wp, ww, 'this wrong answer');
        text(w, 'misconception', wp, ww, { max: 200 });
      });
    }

    function checkNumeric(q, qp, qw) {
      var a = q.answer, ap = qp + '.answer', spec = null;
      if (!isObject(a)) err('missing_answer', ap, qw, '"answer" is required, e.g. { "value": 0.25, "tolerance": { "type": "absolute", "value": 0.01 }, "unit": "mol" }.');
      else {
        unknown(a, ap, qw, ['value', 'tolerance', 'unit']);
        if (typeof a.value !== 'number' || !isFinite(a.value)) err('invalid_answer', ap + '.value', qw, '"answer.value" must be a number (without quotes).');
        else spec = a;
        if (a.tolerance !== undefined) {
          if (!isObject(a.tolerance) || TOLERANCE_TYPES.indexOf(a.tolerance.type) === -1 || typeof a.tolerance.value !== 'number' || !(a.tolerance.value > 0) || !isFinite(a.tolerance.value)) {
            err('invalid_tolerance', ap + '.tolerance', qw, '"answer.tolerance" must be { "type": "absolute" or "relative", "value": a number above 0 }.');
            spec = null;
          } else if (a.tolerance.type === 'relative' && a.tolerance.value >= 0.5) {
            err('invalid_tolerance', ap + '.tolerance', qw, 'A relative tolerance must be below 0.5 (0.02 means within 2%).');
            spec = null;
          }
        }
        text(a, 'unit', ap, qw, { max: 30 });
      }
      pairFeedback(q, qp, qw, ['correct', 'incorrect'], ['a correct answer', 'an incorrect answer']);
      var seen = [];
      wrongAnswers(q, qp, qw, function (w, wp, ww) {
        unknown(w, wp, ww, ['value', 'feedback', 'misconception']);
        if (typeof w.value !== 'number' || !isFinite(w.value)) { err('invalid_answer', wp + '.value', ww, 'Each wrong answer needs a numeric "value".'); return; }
        if (spec && numberMatches(spec, w.value)) err('wrong_answer_is_correct', wp + '.value', ww, 'The wrong answer ' + w.value + ' would be marked correct: it is within the tolerance of the right answer.');
        if (seen.indexOf(w.value) !== -1) err('duplicate_option', wp + '.value', ww, 'The wrong answer ' + w.value + ' is listed twice.');
        seen.push(w.value);
      });
      if (!isText(q.worked_solution)) warn('no_worked_solution', qp + '.worked_solution', qw, 'A calculation question usually needs a "worked_solution".');
    }

    function acceptedList(obj, path, where, required) {
      var v = obj.accepted;
      if (!Array.isArray(v) || !v.length) {
        if (required) err('missing_answer', path + '.accepted', where, '"accepted" is required: every exact answer that should be marked right.');
        return [];
      }
      var out = [];
      v.forEach(function (s, i) {
        if (typeof s !== 'string' || !s.trim() || s.length > LIMITS.shortAnswer) err('invalid_answer', path + '.accepted[' + i + ']', where, 'Each accepted answer must be text of 1 to ' + LIMITS.shortAnswer + ' characters.');
        else out.push(s);
      });
      return out;
    }

    function checkShortText(q, qp, qw) {
      var a = q.answer, ap = qp + '.answer', right = [], cs = false;
      if (!isObject(a)) err('missing_answer', ap, qw, '"answer" is required, e.g. { "accepted": ["ionic", "ionic bonding"] }.');
      else {
        unknown(a, ap, qw, ['accepted', 'case_sensitive']);
        if (a.case_sensitive !== undefined && typeof a.case_sensitive !== 'boolean') err('wrong_type', ap + '.case_sensitive', qw, '"case_sensitive" must be true or false.');
        cs = a.case_sensitive === true;
        right = acceptedList(a, ap, qw, true).map(function (s) { return normaliseText(s, cs); });
      }
      pairFeedback(q, qp, qw, ['correct', 'incorrect'], ['a correct answer', 'an incorrect answer']);
      wrongAnswers(q, qp, qw, function (w, wp, ww) {
        unknown(w, wp, ww, ['accepted', 'feedback', 'misconception']);
        acceptedList(w, wp, ww, true).forEach(function (s, i) {
          if (right.indexOf(normaliseText(s, cs)) !== -1) err('wrong_answer_is_correct', wp + '.accepted[' + i + ']', ww, '"' + s + '" is listed as a wrong answer but is also an accepted right answer.');
        });
      });
    }

    Object.keys(assets).forEach(function (id) {
      if (!assetUse[id]) warn('unused_asset', '$.assets', 'Images', 'The image "' + id + '" is not used by any question.');
    });
    Object.keys(objectives).forEach(function (id) {
      var used = pkg.sections.some(function (s) {
        return isObject(s) && Array.isArray(s.questions) && s.questions.some(function (q) { return isObject(q) && Array.isArray(q.objective_ids) && q.objective_ids.indexOf(id) !== -1; });
      });
      if (!used) warn('unused_objective', '$.objectives', 'Objectives', 'No question assesses objective "' + id + '".');
    });
    return finish();
  }

  // ── Reading a valid package ──────────────────────────────────────────
  function isMastery(section) { return section.type === 'mastery'; }

  // How many times a question in this section may be answered. A mastery
  // check is always once.
  function attemptsAllowed(pkg, section) {
    if (isMastery(section)) return 1;
    var extra = section.retries !== undefined ? section.retries : ((pkg.settings && pkg.settings.retries) || 0);
    return 1 + extra;
  }

  // question id -> { question, section, sectionIndex, questionIndex }
  function index(pkg) {
    var map = new Map();
    pkg.sections.forEach(function (s, si) {
      s.questions.forEach(function (q, qi) { map.set(q.id, { question: q, section: s, sectionIndex: si, questionIndex: qi }); });
    });
    return map;
  }

  function summarise(pkg) {
    var questions = 0, marks = 0, masteryQuestions = 0, types = {}, minutes = 0;
    var sections = pkg.sections.map(function (s) {
      var m = 0;
      s.questions.forEach(function (q) {
        questions++; m += q.marks; types[q.type] = (types[q.type] || 0) + 1;
        if (isMastery(s)) masteryQuestions++;
      });
      marks += m;
      minutes += s.estimated_minutes || 0;
      return { id: s.id, title: s.title, type: s.type, questions: s.questions.length, marks: m, requires: s.requires || [], retries: attemptsAllowed(pkg, s) - 1 };
    });
    return {
      packageId: pkg.package.id, title: pkg.package.title, description: pkg.package.description,
      subject: pkg.package.subject, yearGroup: pkg.package.year_group,
      examBoard: pkg.package.exam_board || null, tier: pkg.package.tier || null,
      contentVersion: pkg.package.content_version, author: pkg.package.author.source,
      estimatedMinutes: pkg.package.estimated_minutes || minutes || null,
      sectionCount: sections.length, questionCount: questions, totalMarks: marks,
      masteryQuestionCount: masteryQuestions, questionTypes: types,
      objectives: pkg.objectives.map(function (o) { return { id: o.id, text: o.text }; }),
      sections: sections
    };
  }

  // The sections of a package an assignment covers, in package order. A
  // null or empty list means the whole package.
  function includedSections(pkg, sectionIds) {
    if (!sectionIds || !sectionIds.length) return pkg.sections;
    return pkg.sections.filter(function (s) { return sectionIds.indexOf(s.id) !== -1; });
  }

  // Why a choice of sections can't be assigned: an unknown id, or a section
  // whose prerequisite was left out.
  function sectionSelectionProblems(pkg, sectionIds) {
    var problems = [], all = {};
    pkg.sections.forEach(function (s) { all[s.id] = s; });
    (sectionIds || []).forEach(function (id) {
      if (!all[id]) { problems.push('Section "' + id + '" is not in this package.'); return; }
      (all[id].requires || []).forEach(function (r) {
        if (sectionIds.indexOf(r) === -1) problems.push('“' + all[id].title + '” needs “' + all[r].title + '” to be assigned with it.');
      });
    });
    return problems;
  }

  // What the browser may hold while a student works: the questions and
  // their options, never an answer, a piece of feedback or a solution.
  function publicQuestion(q) {
    var out = { id: q.id, type: q.type, stem: q.stem, marks: q.marks, difficulty: q.difficulty, objective_ids: q.objective_ids.slice() };
    if (q.asset_ids && q.asset_ids.length) out.asset_ids = q.asset_ids.slice();
    if (q.type === 'mcq') out.options = q.options.map(function (o) { return { id: o.id, text: o.text }; });
    if (q.type === 'numeric' && q.answer.unit) out.unit = q.answer.unit;
    return out;
  }

  function publicPackage(pkg, sectionIds) {
    var sections = includedSections(pkg, sectionIds);
    var kept = {};
    sections.forEach(function (s) { kept[s.id] = true; });
    var used = {};
    var outSections = sections.map(function (s) {
      s.questions.forEach(function (q) { (q.asset_ids || []).forEach(function (id) { used[id] = true; }); });
      return {
        id: s.id, title: s.title, description: s.description, type: s.type, purpose: s.purpose,
        estimated_minutes: s.estimated_minutes || null, mastery: isMastery(s),
        attempts_allowed: attemptsAllowed(pkg, s),
        requires: (s.requires || []).filter(function (id) { return kept[id]; }),
        objective_ids: s.objective_ids.slice(),
        questions: s.questions.map(publicQuestion)
      };
    });
    return {
      schema: SCHEMA,
      package: {
        id: pkg.package.id, title: pkg.package.title, description: pkg.package.description, subject: pkg.package.subject,
        year_group: pkg.package.year_group, exam_board: pkg.package.exam_board || null, tier: pkg.package.tier || null,
        estimated_minutes: pkg.package.estimated_minutes || null
      },
      objectives: pkg.objectives.map(function (o) { return { id: o.id, text: o.text }; }),
      assets: (pkg.assets || []).filter(function (a) { return used[a.id]; })
        .map(function (a) { return { id: a.id, media_type: a.media_type, data: a.data, alt: a.alt, caption: a.caption || null }; }),
      sections: outSections
    };
  }

  // ── Marking ───────────────────────────────────────────────────────────
  function numberMatches(spec, value) {
    var target = spec.value, tol = spec.tolerance;
    if (!tol) return Math.abs(value - target) <= 1e-9 * Math.max(1, Math.abs(target));
    if (tol.type === 'absolute') return Math.abs(value - target) <= tol.value + 1e-12;
    return Math.abs(value - target) <= Math.abs(target) * tol.value + 1e-12;
  }

  function normaliseText(s, caseSensitive) {
    var t = String(s == null ? '' : s);
    if (t.normalize) t = t.normalize('NFKC');
    t = t.trim().replace(/\s+/g, ' ').replace(/[.!?;,]+$/, '').trim();
    return caseSensitive ? t : t.toLowerCase();
  }

  // mark(question, response) -> null if the response can't be read as an
  // answer to this question (nothing is recorded), otherwise
  //   { response, correct, unsure, marks, feedbackKey }
  // `response` is the tidy form that is stored. `feedbackKey` names the
  // authored explanation that belongs to this response.
  //
  // Responses: { notSure: true } | { option: "B" } | { value: true|false }
  //            | { number: "0.25" } | { text: "ionic" }
  function mark(q, response) {
    if (!isObject(response)) return null;
    if (response.notSure === true) return { response: { notSure: true }, correct: false, unsure: true, marks: 0, feedbackKey: 'not_sure' };

    if (q.type === 'mcq') {
      var chosen = typeof response.option === 'string' ? response.option : null;
      if (!chosen || !q.options.some(function (o) { return o.id === chosen; })) return null;
      var right = chosen === q.answer;
      return { response: { option: chosen }, correct: right, unsure: false, marks: right ? q.marks : 0, feedbackKey: 'option:' + chosen };
    }
    if (q.type === 'true_false') {
      if (typeof response.value !== 'boolean') return null;
      var ok = response.value === q.answer;
      return { response: { value: response.value }, correct: ok, unsure: false, marks: ok ? q.marks : 0, feedbackKey: String(response.value) };
    }
    if (q.type === 'numeric') {
      var typed = String(response.number == null ? '' : response.number).trim().slice(0, 60);
      var value = numeric.parseNumber(typed);
      if (value == null) return null;
      if (numberMatches(q.answer, value)) return { response: { number: typed }, correct: true, unsure: false, marks: q.marks, feedbackKey: 'correct' };
      var wrong = q.wrong_answers || [];
      for (var i = 0; i < wrong.length; i++) {
        if (numberMatches({ value: wrong[i].value, tolerance: q.answer.tolerance }, value)) {
          return { response: { number: typed }, correct: false, unsure: false, marks: 0, feedbackKey: 'wrong:' + i };
        }
      }
      return { response: { number: typed }, correct: false, unsure: false, marks: 0, feedbackKey: 'incorrect' };
    }
    if (q.type === 'short_text') {
      var raw = String(response.text == null ? '' : response.text).trim().slice(0, LIMITS.response);
      if (!raw) return null;
      var cs = q.answer.case_sensitive === true, n = normaliseText(raw, cs);
      var match = function (list) { return list.some(function (s) { return normaliseText(s, cs) === n; }); };
      if (match(q.answer.accepted)) return { response: { text: raw }, correct: true, unsure: false, marks: q.marks, feedbackKey: 'correct' };
      var wrongs = q.wrong_answers || [];
      for (var j = 0; j < wrongs.length; j++) {
        if (match(wrongs[j].accepted)) return { response: { text: raw }, correct: false, unsure: false, marks: 0, feedbackKey: 'wrong:' + j };
      }
      return { response: { text: raw }, correct: false, unsure: false, marks: 0, feedbackKey: 'incorrect' };
    }
    return null;
  }

  // The authored explanation for a feedback key, exactly as written.
  function feedbackFor(q, key) {
    if (key === 'not_sure') return { text: q.not_sure.feedback, misconception: null };
    if (key.indexOf('option:') === 0) {
      var id = key.slice(7);
      var o = q.options.filter(function (x) { return x.id === id; })[0];
      return { text: o ? o.feedback : '', misconception: (o && o.id !== q.answer && o.misconception) || null };
    }
    if (key.indexOf('wrong:') === 0) {
      var w = (q.wrong_answers || [])[Number(key.slice(6))];
      return { text: w ? w.feedback : q.feedback.incorrect, misconception: (w && w.misconception) || null };
    }
    return { text: q.feedback[key], misconception: null };
  }

  // The right answer and the general teaching, shown once a question is
  // settled (answered correctly, or no attempts left).
  function reveal(q) {
    var out = { teachingNote: q.teaching_note || null, workedSolution: q.worked_solution || null };
    if (q.type === 'mcq') out.answer = { option: q.answer };
    else if (q.type === 'true_false') out.answer = { value: q.answer };
    else if (q.type === 'numeric') out.answer = { number: q.answer.value, unit: q.answer.unit || null };
    else out.answer = { text: q.answer.accepted[0] };
    return out;
  }

  function evidenceClass(section, attemptNumber) {
    if (isMastery(section)) return 'mastery';
    return attemptNumber === 1 ? 'initial' : 'retry';
  }

  function byAttempt(a, b) { return a.attempt_number - b.attempt_number; }

  // A question's attempts as the player shows them, from its stored rows
  // ({ attempt_number, response, is_correct, is_unsure, marks_awarded,
  // feedback_key }). Each attempt carries the feedback for what was chosen;
  // the answer and worked solution appear only once the question is settled.
  function results(pkg, entry, rows) {
    var q = entry.question, allowed = attemptsAllowed(pkg, entry.section);
    var sorted = rows.slice().sort(byAttempt);
    var settled = sorted.some(function (r) { return r.is_correct; }) || sorted.length >= allowed;
    return sorted.map(function (r, i) {
      var fb = feedbackFor(q, r.feedback_key);
      var last = i === sorted.length - 1;
      return {
        questionId: q.id, attempt: r.attempt_number, attemptsAllowed: allowed,
        response: r.response, correct: !!r.is_correct, unsure: !!r.is_unsure,
        marksAwarded: Number(r.marks_awarded) || 0, marks: q.marks,
        feedback: fb.text, misconception: fb.misconception,
        evidenceClass: evidenceClass(entry.section, r.attempt_number),
        canRetry: last && !settled,
        reveal: last && settled ? reveal(q) : null
      };
    });
  }

  // Evidence for an assignment, from its stored response rows. Nothing here
  // is a prediction or a grade: it counts what happened, and keeps apart
  //   first attempts          what the student understood before any feedback
  //   after feedback          questions eventually answered correctly on a retry
  //   independent mastery     first-and-only attempts in mastery sections
  function progress(pkg, sectionIds, rows) {
    var sections = includedSections(pkg, sectionIds);
    var byQuestion = {};
    rows.forEach(function (r) { (byQuestion[r.question_id] = byQuestion[r.question_id] || []).push(r); });
    Object.keys(byQuestion).forEach(function (k) { byQuestion[k].sort(byAttempt); });

    var complete = {}, objective = {};
    pkg.objectives.forEach(function (o) { objective[o.id] = { id: o.id, text: o.text, questions: 0, attempted: 0, firstCorrect: 0, masteryQuestions: 0, masteryAttempted: 0, masteryCorrect: 0 }; });
    function tally() { return { questions: 0, answered: 0, correct: 0, unsure: 0, marks: 0, marksAvailable: 0, correctAfterFeedback: 0 }; }
    var teaching = tally(), mastery = tally(), resume = null, lastActivity = null;

    var out = sections.map(function (s) {
      var t = tally(), m = isMastery(s), firstUnanswered = null;
      s.questions.forEach(function (q) {
        var attempts = byQuestion[q.id] || [], first = attempts[0];
        t.questions++; t.marksAvailable += q.marks;
        q.objective_ids.forEach(function (id) {
          var o = objective[id];
          if (m) { o.masteryQuestions++; if (first) { o.masteryAttempted++; if (first.is_correct) o.masteryCorrect++; } }
          else { o.questions++; if (first) { o.attempted++; if (first.is_correct) o.firstCorrect++; } }
        });
        if (!first) { if (!firstUnanswered) firstUnanswered = q.id; return; }
        t.answered++;
        if (first.is_correct) t.correct++;
        if (first.is_unsure) t.unsure++;
        t.marks += Number(first.marks_awarded) || 0;
        if (!first.is_correct && attempts.some(function (a) { return a.is_correct; })) t.correctAfterFeedback++;
        attempts.forEach(function (a) { if (a.submitted_at && (!lastActivity || a.submitted_at > lastActivity)) lastActivity = a.submitted_at; });
      });
      complete[s.id] = t.answered === t.questions;
      var target = m ? mastery : teaching;
      Object.keys(t).forEach(function (k) { target[k] += t[k]; });
      return {
        id: s.id, title: s.title, type: s.type, mastery: m,
        questions: t.questions, answered: t.answered, complete: complete[s.id],
        correct: t.correct, unsure: t.unsure, marks: t.marks, marksAvailable: t.marksAvailable,
        correctAfterFeedback: t.correctAfterFeedback, firstUnanswered: firstUnanswered, locked: false
      };
    });

    var kept = {};
    sections.forEach(function (s) { kept[s.id] = true; });
    sections.forEach(function (s, i) {
      out[i].locked = (s.requires || []).some(function (id) { return kept[id] && !complete[id]; });
      if (!resume && !out[i].locked && !out[i].complete) resume = { sectionId: s.id, questionId: out[i].firstUnanswered };
    });

    var questions = teaching.questions + mastery.questions, answered = teaching.answered + mastery.answered;
    return {
      status: answered === 0 ? 'assigned' : (answered === questions ? 'completed' : 'in_progress'),
      questions: questions, answered: answered,
      sectionsTotal: out.length, sectionsComplete: out.filter(function (s) { return s.complete; }).length,
      firstAttempt: teaching,
      mastery: mastery.questions ? mastery : null,
      sections: out,
      objectives: Object.keys(objective).map(function (k) { return objective[k]; })
        .filter(function (o) { return o.questions || o.masteryQuestions; }),
      resume: resume,
      lastActivityAt: lastActivity
    };
  }

  var api = {
    SCHEMA: SCHEMA, QUESTION_TYPES: QUESTION_TYPES, SECTION_TYPES: SECTION_TYPES, DIFFICULTIES: DIFFICULTIES,
    PURPOSES: PURPOSES, ASSET_TYPES: ASSET_TYPES, TOLERANCE_TYPES: TOLERANCE_TYPES, LIMITS: LIMITS,
    validate: validate, summarise: summarise, index: index, includedSections: includedSections,
    sectionSelectionProblems: sectionSelectionProblems, publicPackage: publicPackage, publicQuestion: publicQuestion,
    attemptsAllowed: attemptsAllowed, isMastery: isMastery, mark: mark, feedbackFor: feedbackFor, reveal: reveal,
    evidenceClass: evidenceClass, results: results, progress: progress,
    splitMaths: splitMaths, plainNotation: plainNotation, isInstructional: isInstructional, normaliseText: normaliseText, numberMatches: numberMatches
  };
  root.ITTPackage = api;
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
})(typeof window !== 'undefined' ? window : globalThis);
