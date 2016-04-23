class TagsController < ApplicationController
  before_action :set_tag
  def show
    @dashboard = Dashboard.new(user: current_user, posts: tagged_posts, tag: @tag)
    @related_tags = @tag.related_tags
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tagged_posts
      @_tagged_posts ||= Post.tagged_with(@tag.name).published.includes(:user).paginate(page: params[:page])
    end
end
