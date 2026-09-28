// consent-confirm.html: sends the token from the link to
// /api/v1/consent/verify and shows the result. The token travels in the URL
// fragment (#t=...), which browsers never send to servers or in referrers,
// and is removed from the address bar once read.
(function () {
  var title = document.getElementById('consent-title');
  var message = document.getElementById('consent-message');

  function show(heading, text) {
    title.textContent = heading;
    message.textContent = text;
  }

  var match = /(?:^|[#&])t=([A-Za-z0-9_-]+)/.exec(location.hash);
  var token = match && match[1];
  if (history.replaceState) history.replaceState(null, '', location.pathname);

  if (!token) {
    show('This link is incomplete', 'Please open the link exactly as it appears in the email, or contact us at inspire.science.uk@gmail.com.');
    return;
  }

  fetch('/api/v1/consent/verify', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ token: token })
  })
    .then(function (r) { return r.json(); })
    .then(function (d) {
      if (d && d.success && (d.status === 'verified' || d.status === 'already_verified')) {
        show('Thank you — consent confirmed',
          'Your child can keep learning with Inspire Academic. You can close this page.');
      } else if (d && d.success && d.status === 'withdrawn') {
        show('This consent was withdrawn', 'Please contact us at inspire.science.uk@gmail.com if you would like to give consent again.');
      } else {
        show('We could not confirm this link', (d && d.error && d.error.message) || 'Please contact us at inspire.science.uk@gmail.com.');
      }
    })
    .catch(function () {
      show('Something went wrong', 'Please check your connection and open the link again, or contact us at inspire.science.uk@gmail.com.');
    });
})();
