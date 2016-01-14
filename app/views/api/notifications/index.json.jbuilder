json.array! @notifications do |notification|
  json.actor notification.actor.username
  json.actor_avatar notification.actor.avatar? ? notification.actor.avatar.url : 'default-avatar.jpg'
  json.action notification.action
  json.notifiable do
    json.type notification.notifiable.class.to_s.underscore.humanize.downcase
  end
  json.url case notification.notifiable.class.to_s
           when "Post" then post_path(notification.notifiable)
           when "User" then user_path(notification.notifiable)
           end
end
