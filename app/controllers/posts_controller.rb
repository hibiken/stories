class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to dashboard_url, notice: "Successfully created a post!"
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
