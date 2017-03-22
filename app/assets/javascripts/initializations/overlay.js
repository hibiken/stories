var Overlay = {
  init: function() {
    $('[data-behavior="trigger-overlay"]').click(Overlay.open);
    $('[data-behavior="close-overlay"]').click(Overlay.close);
  },

  open: function(event) {
    event.preventDefault();
    $('[data-behavior="overlay"]').addClass('open');
  },

  close: function(event) {
    event.preventDefault();
    $('[data-behavior="overlay"]').removeClass('open');
  }
};

$(document).on( 'turbolinks:load', Overlay.init );