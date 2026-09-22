(() => {
  const links = document.querySelectorAll('.button[href]');

  links.forEach((link) => {
    link.addEventListener('click', () => {
      document.body.classList.add('page-loading');
    });
  });
})();
