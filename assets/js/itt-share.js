// Inspire Test & Teach: the message a teacher sends with an assignment link.
//
// One wording for every place a link is shared, so homework always arrives
// looking the same. WhatsApp shows *stars* as bold and _underscores_ as
// italic, and builds the picture and title under the message from the link
// itself (the Open Graph tags on student/test-and-teach.html).
//
// The message never contains anything but what the teacher already sees: the
// student's first name, the quiz title and its size, the due date and note.
//
//   ITTShare.message(info)       the text
//   ITTShare.whatsappUrl(info)   a wa.me link that opens WhatsApp with the
//                                text ready, for the teacher to pick a contact
//   info: { link, studentName, title, subject, questionCount,
//           estimatedMinutes, dueAt, note }
(function (root) {
  function firstName(name) {
    var first = String(name || '').trim().split(/\s+/)[0] || '';
    // A placeholder name is not a greeting.
    return /^(unnamed|student)$/i.test(first) ? '' : first;
  }

  function duration(minutes) {
    if (!minutes || minutes < 1) return '';
    if (minutes < 60) return 'about ' + minutes + ' min';
    var h = Math.floor(minutes / 60), m = Math.round((minutes % 60) / 5) * 5;
    if (m === 60) { h += 1; m = 0; }
    return 'about ' + h + ' hr' + (m ? ' ' + m + ' min' : '');
  }

  function dueDate(iso) {
    if (!iso) return '';
    var d = new Date(iso);
    return isNaN(d) ? '' : d.toLocaleDateString('en-GB', { weekday: 'long', day: 'numeric', month: 'long' });
  }

  // WhatsApp would read a stray * or _ in a title as formatting.
  function plain(text) {
    return String(text == null ? '' : text).replace(/[*_~`]/g, '').replace(/\s+/g, ' ').trim();
  }

  function message(info) {
    var name = firstName(info.studentName);
    var facts = [plain(info.subject), info.questionCount ? info.questionCount + (info.questionCount === 1 ? ' question' : ' questions') : '', duration(info.estimatedMinutes)].filter(Boolean);
    var due = dueDate(info.dueAt), note = plain(info.note);
    var lines = [
      '*INSPIRE ACADEMIC*',
      '_Test & Teach · Homework assigned_',
      '',
      name ? 'Hello ' + plain(name) + ',' : 'Hello,',
      '',
      'You have been assigned a new homework:',
      '',
      '*' + plain(info.title) + '*'
    ];
    if (facts.length) lines.push(facts.join(' · '));
    if (due) lines.push('*Due:* ' + due);
    if (note) lines.push('', '*From your teacher:* ' + note);
    lines.push(
      '',
      'Open your assignment:',
      info.link,
      '',
      'Sign in with your Inspire Academic account. Your answers are saved as you go, so you can stop and carry on later.',
      '',
      '_Inspire Academic · inspireacademic.org_'
    );
    return lines.join('\n');
  }

  function whatsappUrl(info) {
    return 'https://wa.me/?text=' + encodeURIComponent(message(info));
  }

  var api = { message: message, whatsappUrl: whatsappUrl, duration: duration };
  root.ITTShare = api;
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
})(typeof window !== 'undefined' ? window : globalThis);
