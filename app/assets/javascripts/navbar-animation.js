var Navbar = {
  animate: function() {
    var lastScrollTop = 0;
    var $navbar = $('[data-behavior="animated-navbar"]');
    var $metadataBar = $('[data-behavior="animated-metadata"]');
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

      if (st > lastScrollTop) {
        $metadataBar.removeClass('is-inView');
        $metadataBar.addClass('is-hidden');
      } else {
        $metadataBar.removeClass('is-hidden');
        $metadataBar.addClass('is-inView');
      }
      lastScrollTop = st;
    });
  }
};

$(document).ready( Navbar.animate );
$(document).on( 'page:load', Navbar.animate );

