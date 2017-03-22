var ElementTransitions = {
  init: function() {
    $(document).on('turbolinks:request-start.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeOutDown');
      $('[data-animation="fadeInUp-fadeOutDown-slow"]').addClass('animated fadeOutDown-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceOutLeft');
    });

    $(document).on('turbolinks:load.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeInUp');
      $('[data-animation="fadeInUp-fadeOutDown-slow"]').addClass('animated fadeInUp-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceInLeft');
    });
  }

};

$(document).on('turbolinks:load', ElementTransitions.init);