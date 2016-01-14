function notificationsInitialize() {

  $notifications = $('#notifications');
  $dropdown = $('#notification-items');
  $bell = $('#bell');

  $unreadCount = $('<span id="unread-notifications-count"></span>');
  

  var renderNotifications = function(data) {
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

      return '<li><a href="' + notification.url + '">' + imageTag + itemContent + '</a></li>';
    });


    if (items.length > 0) {
      $dropdown.html(items.join(' '));
      $unreadCount.text(items.length);
      $bell.after($unreadCount);
      $bell.hide();
      $notifications.addClass('active');
    } else {
      $dropdown.html("<li><a>No notifications yet</a></li>");
    }
  };

  var markAsRead = function() {
    $.ajax({
      url: '/api/notifications/mark_as_read',
      method: 'POST',
      dataType: 'JSON',
      success: function() {
        $bell.show();
        $notifications.removeClass('active');
        $unreadCount.hide();
      }
    });
  };

  /** Click handler to clear notifications **/
  $notifications.click(markAsRead);

  
  if ($notifications.length > 0) {
    $.ajax({
      url: "/api/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: renderNotifications
    });
  }
}


$(document).ready( notificationsInitialize );
$(document).on( 'page:load', notificationsInitialize );
