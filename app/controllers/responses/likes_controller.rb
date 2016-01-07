class Responses::LikesController < LikesController
  before_action :set_likeable

  private

    def set_likeable
      @likeable = Response.find(params[:response_id])
    end
end
