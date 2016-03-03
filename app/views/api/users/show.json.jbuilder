json.user_id @user.id
json.username @user.username
json.description @user.description
json.followingCount @user.following.size
json.followerCount @user.followers.size
json.isFollowing current_user.following?(@user)


