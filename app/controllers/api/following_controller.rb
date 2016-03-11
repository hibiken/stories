class API::FollowingController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @following = user.following.paginate(page: params[:page], per_page: 6)
    @current_page = @following.current_page
    @next_page = @following.next_page
  end
end
