$unreadCount = $('<span id="unread-notifications-count"></span>');


var Notification = {

  setup: function() {
    if ($('#notifications').length > 0) {
      $.ajax({
        url: "/api/notifications.json",
        dataType: "JSON",
        method: "GET",
        success: Notification.render
      });
    }

    $('#notifications').click(Notification.markAsRead);
  },

  render: function(data) {
    console.log(data);
    var itemContent, imageTag;

    var items = $.map(data, function(notification) {
      switch(notification.type) {
        case "post":
          itemContent = notification.actor + " " + notification.action + " " + notification.type;
          break;
        case "user":
          itemContent = notification.actor + " " + notification.action;
          break;
        case "response":
          itemContent = notification.actor + " " + notification.action + " " + notification.type
          break;
      }
      imageTag = '<img width="35" class="avatar-image" src="' + notification.actor_avatar + '"/>';

      return '<li><a href="' + notification.url + '">' + imageTag + itemContent + '</br><small>' + notification.time_ago + '</small></a></li>';
    });

    if (items.length > 0) {
      $('#notification-items').html(items.join(' '));
      $unreadCount.text(items.length);
      $('#bell').after($unreadCount);
      $('#bell').hide();
      $('#notifications').addClass('active');
    } else {
      $('#notification-items').html("<li><a>No notifications yet</a></li>");
    }
  },

  markAsRead: function() {
    $.ajax({
      url: '/api/notifications/mark_as_read',
      method: 'POST',
      dataType: 'JSON',
      success: function() {
        $('#bell').show();
        $('#notifications').removeClass('active');
        $unreadCount.hide();
      }
    });
  }
}


$(document).ready( Notification.setup );
$(document).on( 'page:load', Notification.setup );
