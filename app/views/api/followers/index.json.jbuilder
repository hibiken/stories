json.array! @followers do |follower|
  json.id follower.id
  json.username follower.username
  json.avatar_image_tag avatar_for(follower, size: 50)
  json.description follower.description
  json.urlPath user_path(follower)
  json.following user_signed_in? && current_user.following?(follower)
  json.isSelf user_signed_in? && current_user?(follower)
  json.currentPage @current_page
  json.nextPage @next_page
end
