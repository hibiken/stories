class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.add_like_to(@post)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    Like.find(params[:id]).destroy
    redirect_to @post
  end
end
