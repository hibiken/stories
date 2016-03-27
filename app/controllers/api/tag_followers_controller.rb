class API::TagFollowersController < ApplicationController
  def index
    tag = Tag.friendly.find(params[:tag_id])
    @followers = tag.followers
  end
end
