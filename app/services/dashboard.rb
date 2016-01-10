class Dashboard
  attr_reader :tag

  def initialize(user: nil, filter: nil, tag: nil )
    @user = user
    @filter = filter
    @tag = tag
  end

  def posts
    if @tag
      return Post.tagged_with(@tag.name)
    end

    case @filter
    when :bookmarks
      return @user.bookmarked_posts
    end

    if @user
      return Post.all.limit(8) # TODO: change this to Timeline.new(@user) or something like that
    else
      return Post.all.limit(8)
    end
  end

  def featured_tags
    Tag.all.limit(8) # TODO: Change this to something like Tag.where(featured: true)
  end

  def following_tags
    @user.following_tags
  end

  def new_post
    Post.new
  end
end
