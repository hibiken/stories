class Feed
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def posts(page: nil)
    Post.recent.where(id: feed_post_ids).published.includes(:user).paginate(page: page)
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

  def featured?(post)
    featured_post_ids.include?(post.id)
  end

  def tag_for(post)
    tag_id = user.following_tag_ids.select { |id| post.tag_ids.include?(id) }.first
    Tag.find_by(id: tag_id)
  end

  def recommender_for(post)
    user_id = user.following_ids.select { |id| post.liker_ids.include?(id) }.first
    User.find_by(id: user_id)
  end

  private

     def user_ids
       @_user_ids ||= user.following_ids + [user.id]
     end

     def following_users_post_ids
       @_following_users_post_ids ||= Post.where(user_id: user.following_ids).pluck(:id)
     end

     def tagged_post_ids
       @_tagged_post_ids ||= Tagging.where(tag_id: user.following_tag_ids).distinct.pluck(:post_id)
     end

     def featured_post_ids
       @_featured_post_ids ||= Post.where(featured: true).pluck(:id)
     end

     def feed_post_ids
       @_feed_post_ids ||= (Post.where(user_id: user_ids).pluck(:id) + tagged_post_ids + recommended_post_ids + featured_post_ids).uniq
     end

     def recommended_post_ids
       @_recommended_post_ids ||= Post.joins(:likes).where(likes: { user_id: user.following_ids }).distinct.pluck(:id)
     end
end
