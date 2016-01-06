class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_following_tags

  def show
    @posts = Post.all.includes(:user)
    @featured_tags = Tag.all.limit(8) # TODO: Tag.where(featured: true) or something like that.
  end
end
