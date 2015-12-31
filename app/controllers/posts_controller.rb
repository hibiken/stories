class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to posts_url, notice: "Successfully created a post!"
    else
      flash.now[:alert] = "Could not save the post, Please try again"
      render :new
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
