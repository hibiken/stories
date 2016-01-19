class SearchController < ApplicationController
  before_action :beautify_url
  layout "simple"

  def show
    @posts = Post.search(params[:q]).records.to_a
    @users = User.search(params[:q]).records.to_a
  end

  private

    def beautify_url
      if params[:search].present?
        redirect_to search_url(q: params[:search][:q])
      end
    end
end
