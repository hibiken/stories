# This controller serves as a base controller for other bookmarks_controllers.
# Posts::BookmarksController for example.
# Child controller that inherit from this BookmarksController should implement
# before_action :set_bookmarkable, which sets @bookmarkable.
class API::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmarkable

  def create
    current_user.add_bookmark_to(@bookmarkable)
    render json: { bookmarked: true, type: @bookmarkable.class.to_s, id: @bookmarkable.id }, status: 200
  end

  def destroy
    current_user.remove_bookmark_from(@bookmarkable)
    render json: { bookmarked: false, type: @bookmarkable.class.to_s, id: @bookmarkable.id }, status: 200
  end

  private

    def set_bookmarkable
      raise NotImplementedError, "This #{self.class} cannot respond to 'set_bookmarkable'"
    end
end
