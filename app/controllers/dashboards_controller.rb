class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = Post.all.includes(:user)
    if user_signed_in?
      @following_tags = current_user.following_tags
    end
  end
end
