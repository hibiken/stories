class SearchController < ApplicationController
  def search
    @posts = Post.search(params[:search][:q]).records.to_a
  end
end
