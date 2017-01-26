class PostDecorator < DelegateClass(Post)
  def initialize(post, current_user)
    super(post)
    @feed = Feed.new(current_user)
  end

  def tagged?
    @feed.tagged?(self)
  end

  def recommended?
    @feed.recommended?(self)
  end

  def featured?
    @feed.featured?(self)
  end

  def tag
    @feed.tag_for(self)
  end

  def recommender
    @feed.recommender_for(self)
  end
end
