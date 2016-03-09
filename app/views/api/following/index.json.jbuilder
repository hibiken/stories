json.array! @following do |user|
  json.id user.id
  json.username user.username
  json.avatar_image_tag avatar_for(user, size: 50)
  json.description user.description
  json.urlPath user_path(user)
  json.following user_signed_in? && current_user.following?(user)
  json.isSelf user_signed_in? && current_user?(user)
  json.currentPage @current_page
  json.nextPage @next_page
end
