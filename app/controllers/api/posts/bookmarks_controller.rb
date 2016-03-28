class API::Posts::BookmarksController < API::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Post.find(params[:post_id])
    end
end
