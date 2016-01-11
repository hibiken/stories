class Dashboard
  attr_reader :tag, :filter

  def initialize(user: nil, filter: nil, tag: nil )
    @user = user
    @filter = filter
    @tag = tag
  end

  def tag_posts
    Post.tagged_with(@tag.name)
  end

  def filtered_posts
    case @filter
    when :bookmarks
      return @user.bookmarked_posts
    end
  end

  def posts
    Post.all.limit(8)
  end

  def feed
    Feed.new(@user)
  end

  def featured_tags
    Tag.all.limit(8) # TODO: Change this to something like Tag.where(featured: true)
  end

  def following_tags
    @user.following_tags unless @user.nil?
  end

  def new_post
    Post.new
  end

  def filtered?
    !@filter.nil?
  end

  def with_tag?
    !@tag.nil?
  end

  def non_filtered?
    @filter.nil? && @tag.nil?
  end
end
