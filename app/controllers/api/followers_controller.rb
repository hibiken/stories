class API::FollowersController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @followers = user.followers
  end
end
