var scroll = 20;

Mousetrap.bind('j', function () {
  window.scrollBy(0, scroll);
});

Mousetrap.bind('k', function () {
  window.scrollBy(0, -scroll);
});
