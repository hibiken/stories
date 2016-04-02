var ElementTransitions = {
  init: function() {
    $(document).on('page:fetch.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeOutDown');
      $('[data-animation="fadeInUp-fadeOutDown-slow"]').addClass('animated fadeOutDown-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceOutLeft');
    });

    $(document).on('page:change.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeInUp');
      $('[data-animation="fadeInUp-fadeOutDown-slow"]').addClass('animated fadeInUp-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceInLeft');
    });
  }

};

$(document).ready(ElementTransitions.init);
$(document).on('page:load', ElementTransitions.init);
