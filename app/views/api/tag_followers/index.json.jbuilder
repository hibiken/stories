json.array! @followers do |follower|
  json.id follower.id
  json.username follower.username
  json.avatar_image_tag avatar_for(follower, size: 40)
  json.urlPath user_path(follower)
end
