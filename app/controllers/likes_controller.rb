class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_like_to(@likeable)
    redirect_to :back
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to :back
  end
end
