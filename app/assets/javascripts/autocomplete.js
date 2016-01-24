var Autocomplete = {
  setup: function() {
    $("#search_q").autocomplete({
      source: '/autocomplete',
      minLength: 2
    });
  }
};

$(document).ready(Autocomplete.setup);
$(document).on('page:load', Autocomplete.setup);

