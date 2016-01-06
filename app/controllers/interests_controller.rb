class InterestsController < ApplicationController
  before_action :authenticate_user!

  # Follow a tag.
  def create
    tag = Tag.find(params[:tag_id])
    current_user.follow_tag(tag)
    redirect_to tag
  end

  # Unfollow a tag.
  def destroy
    tag = Interest.find(params[:id]).tag
    current_user.unfollow_tag(tag)
    redirect_to tag
  end
end
