class Admin::FeaturedPostsController < ApplicationController
  before_action :authenticate_admin!

  def create
    post.update(featured: true)
    redirect_to post
  end

  def destroy
    post.update(featured: false)
    redirect_to post
  end

  private

    def post
      @_post ||= Post.find(params[:post_id])
    end
end
