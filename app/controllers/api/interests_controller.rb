class API::InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag

  # Follow a tag.
  def create
    current_user.follow_tag(@tag)
    head status: 200
  end

  # Unfollow a tag.
  def destroy
    current_user.unfollow_tag(@tag)
    head status: 200
  end

  private

    def set_tag
      @tag = Tag.find(params[:tag_id])
    end
end
