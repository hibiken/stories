class Dashboard
  attr_reader :user, :posts, :tag, :filter

  def initialize(user: nil, posts: nil, tag: nil, filter: nil )
    @user = user
    @posts = posts
    @tag = tag
    @filter = filter
  end

  def featured_tags
    Tag.where(featured: true)
  end

  def following_tags
    user.following_tags unless user.nil?
  end

  def all_tags
    Tag.all.limit(50)
  end

  def top_stories
    Post.published.top_stories(5).includes(:user)
  end

  def new_post
    @user.posts.new
  end

  def filtered?
    filter.present?
  end

  def top_stories?
    filter == :top_stories
  end
end
