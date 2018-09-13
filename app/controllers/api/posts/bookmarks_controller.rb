class Api::Posts::BookmarksController < Api::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Post.find(params[:post_id])
    end
end
