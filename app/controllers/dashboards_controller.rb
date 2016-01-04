class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = Post.all.includes(:user)
  end
end
