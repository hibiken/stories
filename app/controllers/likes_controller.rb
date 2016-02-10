# This controller serves as a parent controller for other likes_controllers. 
# Posts::LikesController for example.
# Child controller that inherit from this LikesController should implement 
# before_action :set_likeable, which sets @likeable.
class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    current_user.add_like_to(@likeable)
    # Notify the user
    unless current_user?(@likeable.user)
      Notification.create(recipient: @likeable.user, actor: current_user, action: "liked your", notifiable: @likeable)
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
    
  end

  def destroy
    current_user.remove_like_from(@likeable)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

    def set_likeable
      raise NotImplementedError, "This #{self.class} cannot respond to 'set_likeable'"
    end
end
