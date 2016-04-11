$loading = $('<div class="loader"><div class="bullet"></div><div class="bullet"></div><div class="bullet"></div><div class="bullet"></div></div>');

var EndlessScroll = {
  init: function() {
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

$(document).ready( EndlessScroll.init );
$(document).on( 'page:load', EndlessScroll.init );
