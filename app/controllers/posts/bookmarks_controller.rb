class Posts::BookmarksController < BookmarksController
  before_action :set_bookmarkable

  private

    def set_bookmarkable
      @bookmarkable = Post.find(params[:post_id])
    end
end
