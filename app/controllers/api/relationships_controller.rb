class API::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  # Follow a user.
  def create
    current_user.follow(@user)
    # Notify the user
    Notification.create(recipient: @user, actor: current_user, action: "started following you", notifiable: current_user, is_new: true)
    render json: { followerCount: @user.followers.size }, render: 200
  end

  # Unfollow a user.
  def destroy
    current_user.unfollow(@user)
    render json: { followerCount: @user.followers.size }, render: 200
  end

  private

    def set_user
      @user = User.find(params[:followed_id])
    end
end
