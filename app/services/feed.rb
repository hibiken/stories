class Feed
  include ActiveModel::Model
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def posts
    Post.recent.find(feed_post_ids)
  end

  def tagged?(post)
    tagged_post_ids.include?(post.id)
  end

  def following_author?(post)
    following_users_post_ids.include?(post.id)
  end

  def recommended?(post)
    recommended_post_ids.include?(post.id)
  end

  def tag_for(post)
    tag_id = @user.following_tag_ids.select { |id| post.tag_ids.include?(id) }.first
    Tag.find_by(id: tag_id)
  end

  def recommender_for(post)
    user_id = @user.following_ids.select { |id| post.liker_ids.include?(id) }.first
    User.find_by(id: user_id)
  end

  private

     def user_ids
       @user.following_ids + [@user.id]
     end

     def following_users_post_ids
       Post.where(user_id: @user.following_ids).pluck(:id)
     end

     def tagged_post_ids
       Tagging.where(tag_id: @user.following_tag_ids).pluck(:post_id).uniq
     end

     def feed_post_ids
       (Post.where(user_id: user_ids).pluck(:id) + tagged_post_ids + recommended_post_ids).uniq
     end

     def recommended_post_ids
       post_ids = []
       @user.following.each { |user| post_ids << user.liked_post_ids }
       post_ids.flatten.uniq
     end
end
