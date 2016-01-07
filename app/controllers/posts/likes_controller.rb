class Posts::LikesController < LikesController
  before_action :set_likeable

  private

    def set_likeable
      @likeable = Post.find(params[:post_id])
    end
end
