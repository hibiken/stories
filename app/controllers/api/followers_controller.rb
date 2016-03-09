class API::FollowersController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @followers = user.followers.paginate(page: params[:page], per_page: 6)
    @current_page = @followers.current_page
    @next_page = @followers.next_page
  end
end
