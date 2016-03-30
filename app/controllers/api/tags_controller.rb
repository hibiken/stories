class API::TagsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:tag_name].strip.present?
      tag = Tag.first_or_create_with_name!(params[:tag_name])
      current_user.following_tags << tag unless current_user.following_tag?(tag)
    end
    render json: tag.to_json, status: 200
  end
end
