class Feed
  include ActiveModel::Model
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def posts
    Post.find(post_ids)
  end

  def tagged?(post)
    tagged_post_ids.include?(post.id)
  end

  def following_author?(post)
    following_users_post_ids.include?(post.id)
  end

  def tag_for(post)
    tag_id = @user.following_tag_ids.select { |id| post.tag_ids.include?(id) }.first
    Tag.find_by(id: tag_id)
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

     def post_ids
       Post.where(user_id: user_ids).pluck(:id) + tagged_post_ids
     end
end
