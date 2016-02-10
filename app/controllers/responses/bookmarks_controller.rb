class Responses::BookmarksController < BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Response.find(params[:response_id])
    end
end
