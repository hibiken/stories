var ProgressBar = {
  setup: function() {
    // Hook into Turbolinks event
    $(document).on('page:fetch', function() {
      $('[data-behavior="progress-bar"]').addClass('active');
    });

    $(document).on('page:load', function() {
      $('[data-behavior="progress-bar"]').removeClass('active');
    });
  }
};

$(document).ready(ProgressBar.setup);
$(document).on('page:load', ProgressBar.setup);
