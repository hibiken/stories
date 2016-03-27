class API::Posts::BookmarksController < API::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Post.friendly.find(params[:post_id])
    end
end
