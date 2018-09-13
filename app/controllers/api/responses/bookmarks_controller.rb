class Api::Responses::BookmarksController < Api::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Response.find(params[:response_id])
    end
end
