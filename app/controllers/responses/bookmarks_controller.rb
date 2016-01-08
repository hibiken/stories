class Responses::BookmarksController < BookmarksController
  before_action :set_bookmarkable

  private

    def set_bookmarkable
      @bookmarkable = Response.find(params[:response_id])
    end
end
