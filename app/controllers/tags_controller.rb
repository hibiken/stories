class TagsController < ApplicationController
  before_action :set_tag
  def show
    @dashboard = Dashboard.new(user: current_user, posts: tagged_posts, tag: @tag)
    respond_to do |format|
      format.html { render 'dashboards/show' }
      format.js   { render 'dashboards/show' }
    end
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tagged_posts
      @_tagged_posts ||= Post.tagged_with(@tag.name).paginate(page: params[:page])
    end
end
