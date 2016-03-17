class API::Responses::BookmarksController < API::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Response.find(params[:response_id])
    end
end
