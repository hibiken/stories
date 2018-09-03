json.array! @likers do |liker|
  json.id liker.id
  json.username liker.username
  json.avatar_image_tag avatar_for(liker, size: 50)
  json.description liker.description
  json.urlPath user_path(liker)
  json.following current_user.following?(liker)
  json.isSelf current_user?(liker)
  json.currentPage @current_page
  json.nextPage @next_page
end
