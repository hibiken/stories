class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_bookmark_to(@bookmarkable)
    redirect_to :back
  end

  def destroy
    Bookmark.find(params[:id]).destroy
    redirect_to :back
  end
end
