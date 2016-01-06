class TagsController < ApplicationController
  before_action :set_following_tags

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end
end
