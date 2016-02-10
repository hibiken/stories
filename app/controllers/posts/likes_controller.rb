class Posts::LikesController < LikesController

  private

    def set_likeable
      @likeable = Post.find(params[:post_id])
    end
end
