class API::LikersController < ApplicationController
  before_action :authenticate_user!
  def index
    post = Post.find(params[:post_id])
    @likers = post.likers.paginate(page: params[:page], per_page: 6)
    @current_page = @likers.current_page
    @next_page = @likers.next_page
  end
end
