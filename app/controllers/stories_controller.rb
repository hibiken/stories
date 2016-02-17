class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @drafts = current_user.posts.drafts
    @published_posts = current_user.posts.published
  end
end
