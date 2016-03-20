json.posts do |json|
  json.array! @posts do |post|
    json.id post.id
    json.title truncate(post.title, length: 48)
    json.avatar_url post.user.avatar_url.present? ? post.user.avatar_url : image_path('default-avatar.jpg')
    json.url post_path(post.id)
  end
end

json.users do |json|
  json.array! @users do |user|
    json.id user.id
    json.username user.username
    json.avatar_url user.avatar_url.present? ? user.avatar_url : image_path('default-avatar.jpg')
    json.url user_path(user.id)
  end
end
