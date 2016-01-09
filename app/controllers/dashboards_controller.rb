class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_following_tags

  def show
    case params[:filter]
    when 'bookmarks'
      @posts = current_user.bookmarked_posts.includes(:user)
    else
      @posts = Post.all.includes(:user)
    end
    @featured_tags = Tag.all.limit(8) # TODO: Tag.where(featured: true) or something like that.
  end
end
