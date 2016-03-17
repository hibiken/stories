class API::FollowingTagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = current_user.following_tags
  end
end
