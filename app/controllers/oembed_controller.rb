class OembedController < ApplicationController
  before_action :authenticate_user!

  def show
    oembed = Oembed.new
    render json: oembed.get(params[:url])
  end
end
