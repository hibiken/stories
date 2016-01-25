json.array! @posts do |post|
  json.title truncate(post.title, length: 48)
  json.avatar_url post.user.avatar? ? post.user.avatar.url : '/assets/default-avatar.jpg'
  json.url post_path(post.id)
end
