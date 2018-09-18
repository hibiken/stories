class Api::Responses::LikesController < Api::LikesController

  private

    def set_likeable
      @likeable = Post.find(params[:response_id])
    end
end
