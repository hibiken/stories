class API::LikersController < ApplicationController
  before_action :authenticate_user!
  def index
    post = Post.find(params[:post_id])
    @likers = post.likers
  end
end
