json.id @user.id
json.username @user.username
json.description @user.description
json.location @user.location
json.avatar_image_tag avatar_for(@user, size: 50)
json.urlPath user_path(@user)
json.followingCount @user.following.size
json.followerCount @user.followers.size
json.isFollowing current_user.following?(@user) if user_signed_in?
json.hideButton user_signed_in? && current_user?(@user)

