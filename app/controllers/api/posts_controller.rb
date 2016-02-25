class API::PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)
    @post.save(validate: false)
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    @post.save(validate: false)
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :all_tags, :picture)
    end
end
