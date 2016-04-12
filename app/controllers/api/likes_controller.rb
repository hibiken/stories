# This controller serves as a parent controller for other likes_controllers. 
# Posts::LikesController for example.
# Child controller that inherit from this LikesController should implement 
# before_action :set_likeable, which sets @likeable.
class API::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    current_user.add_like_to(@likeable)
    notify_author
    render json: { liked: true, count: @likeable.reload.likes.size, type: @likeable.class.to_s, id: @likeable.id }, status: 200
  end

  def destroy
    current_user.remove_like_from(@likeable)

    render json: { liked: false, count: @likeable.reload.likes.size, type: @likeable.class.to_s, id: @likeable.id }, status: 200
  end

  private

    def set_likeable
      raise NotImplementedError, "This #{self.class} cannot respond to 'set_likeable'"
    end

    def notify_author
      unless current_user?(@likeable.user)
        Notification.create(recipient: @likeable.user, actor: current_user, action: "liked your", notifiable: @likeable, is_new: true)
      end
    end
end

