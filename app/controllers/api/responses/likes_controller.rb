class Api::Responses::LikesController < Api::LikesController

  private

    def set_likeable
      @likeable = Response.find(params[:response_id])
    end
end
