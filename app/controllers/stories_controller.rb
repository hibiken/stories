class StoriesController < ApplicationController
  before_action :authenticate_user!

  def drafts
    @drafts = current_user.posts.drafts
  end

  def published
    @posts = current_user.posts.published
  end
end
