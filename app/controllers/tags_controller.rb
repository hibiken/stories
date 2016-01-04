class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end
end
