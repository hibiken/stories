var EndlessScroll = {
  setup: function() {
    if ($('[data-behavior="endless-scroll"]').length > 0) {
      $(window).scroll(function() {
        var url = $('.pagination .next_page').attr('href');
        if ( url && ($(window).scrollTop() > $(document).height() - $(window).height() - 80) ) {
          $('.pagination').text("Fetching more posts");
          $.getScript(url);
        }
      });
    }
  }
};

$(document).ready( EndlessScroll.setup );
$(document).on( 'page:load', EndlessScroll.setup );

