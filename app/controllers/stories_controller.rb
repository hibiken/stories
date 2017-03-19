class StoriesController < ApplicationController
  before_action :authenticate_user!

  def drafts
    @drafts = current_user.posts.recent.drafts.active
  end

  def published
    @posts = current_user.posts.recent.published.active
  end

  def archived
  	@archived_posts = current_user.posts.recent.published.archived
  end
end
