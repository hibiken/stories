class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  layout "editor", only: [:new, :edit]

  def show
    @response = Response.new
  end

  def new
    @post = Post.new_draft_for(current_user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.publish
      redirect_to @post, notice: "Successfully published the post!"
    else
      @post.unpublish
      flash.now[:alert] = "Could not update the post, Please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)
    if @post.publish
      redirect_to @post, notice: "Successfully published the post!"
    else
      @post.unpublish
      flash.now[:alert] = "Could not update the post, Please try again"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url, notice: "Successfully deleted the post"
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :all_tags, :picture)
    end

    def authorize_user
      redirect_to root_url unless current_user?(@post.user)
    end
end
