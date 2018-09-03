class StoriesController < ApplicationController
  before_action :authenticate_user!

  def drafts
    @drafts = current_user.posts.recent.drafts
  end

  def published
    @posts = current_user.posts.recent.published
  end
end
