class API::PostsController < ApplicationController
  before_action :authenticate_user!

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.published?
      @post.save
    else
      @post.save_as_draft
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :all_tags, :picture)
    end
end
