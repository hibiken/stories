class RecommendedPostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recommended_posts = @user.liked_posts.published
  end
end
