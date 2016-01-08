class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_bookmark_to(@bookmarkable)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    Bookmark.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
