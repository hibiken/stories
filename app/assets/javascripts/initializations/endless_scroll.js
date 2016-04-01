$loading = $('<div class="loader-container"><div class="loader"><div class="loader-dot"></div><div class="loader-dot"></div><div class="loader-dot"></div><div class="loader-dot"></div><div class="loader-dot"></div><div class="loader-dot"></div><div class="loader-text"></div></div></div>');

var EndlessScroll = {
  setup: function() {
    if ($('[data-behavior="endless-scroll"]').length > 0) {
      $(window).scroll(function() {
        var url = $('.pagination .next_page').attr('href');
        if ( url && ($(window).scrollTop() > $(document).height() - $(window).height() - 80) ) {
          $('.pagination').html($loading);
          $.getScript(url);
        }
      });
      $(window).scroll();
    }
  }
};

$(document).ready( EndlessScroll.setup );
$(document).on( 'page:load', EndlessScroll.setup );

