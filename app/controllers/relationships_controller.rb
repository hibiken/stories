class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # Follow a user.
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    # Notify the user
    Notification.create(recipient: user, actor: current_user, action: "started following you", notifiable: current_user)
    redirect_to user
  end

  # Unfollow a user.
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
