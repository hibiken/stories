# This controller serves as a parent controller for other likes_controllers. Posts::LikesController for example.
# Child controller that inherit from this LikesController should implement before_action :set_likeable, which sets @likeable.
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
