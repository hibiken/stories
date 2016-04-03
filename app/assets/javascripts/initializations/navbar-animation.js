var NavbarAnimation = {
  init: function() {
    var lastScrollTop = 0;
    var $navbar = $('[data-behavior="animated-navbar"]');
    $(window).scroll(function(event) {
      var st = $(this).scrollTop();
      if (st > 500 && st > lastScrollTop) {
        // downscroll event
        $navbar.removeClass('is-inView');
        $navbar.addClass('is-hidden');
      } else {
        // upscroll event
        $navbar.removeClass('is-hidden');
        $navbar.addClass('is-inView');
      }
      lastScrollTop = st;
    });
  }
};

$(document).ready( NavbarAnimation.init );
$(document).on( 'page:load', NavbarAnimation.init );

