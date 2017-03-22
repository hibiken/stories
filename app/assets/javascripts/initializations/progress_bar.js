var ProgressBar = {
  init: function() {
    // Hook into Turbolinks event
    $(document).on('turbolinks:request-start', function() {
      $('[data-behavior="progress-bar"]').addClass('active');
    });

    $(document).on('turbolinks:request-end', function() {
      $('[data-behavior="progress-bar"]').removeClass('active');
    });
  }
};

// override default progress bar
// turbolinks version > 3 provides default progress bar
Turbolinks.ProgressBar.prototype.refresh = function() {};
Turbolinks.ProgressBar.defaultCSS = "";

// custom 50ms threshold to show progress bar
// default is 500ms 
// Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
//   return this.progressBarTimeout = setTimeout(this.showProgressBar, 50);
// };

$(document).on('turbolinks:load', ProgressBar.init);