class Admin::FeaturedTagsController < ApplicationController
  before_action :authenticate_admin!

  def create
    tag.update(featured: true)
    redirect_to tag
  end

  def destroy
    tag.update(featured: false)
    redirect_to tag
  end

  protected

    def tag
      @_tag ||= Tag.find(params[:tag_id])
    end
end
