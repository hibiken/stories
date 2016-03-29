class API::TagsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:tag_name].strip.present?
      tag = Tag.where(name: params[:tag_name].strip).first_or_create!
      unless current_user.following_tags.include?(tag)
        current_user.following_tags << tag
      end
    end
    render nothing: true, status: 200
  end
end
