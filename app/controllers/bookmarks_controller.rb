# This controller serves as a base controller for other bookmarks_controllers.
# Posts::BookmarksController for example.
# Child controller that inherit from this BookmarksController should implement
# before_action :set_bookmarkable, which sets @bookmarkable.
class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmarkable

  def create
    current_user.add_bookmark_to(@bookmarkable)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    current_user.remove_bookmark_from(@bookmarkable)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

    def set_bookmarkable
      raise NotImplementedError, "This #{self.class} cannot respond to 'set_bookmarkable'"
    end
end
