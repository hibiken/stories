class Posts::BookmarksController < BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Post.find(params[:post_id])
    end
end
