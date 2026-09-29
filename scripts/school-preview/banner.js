// Preview banner: shows who the page is acting as and switches user.
(function () {
  let who = 'teacher';
  try { who = localStorage.getItem('preview-user') || 'teacher'; } catch (e) { /* default */ }
  const cur = document.getElementById('preview-current');
  if (cur) cur.textContent = '(now: ' + who + ')';
  document.querySelectorAll('[data-preview-user]').forEach(b => b.addEventListener('click', () => {
    try { localStorage.setItem('preview-user', b.dataset.previewUser); } catch (e) { /* ignore */ }
    location.reload();
  }));
})();
