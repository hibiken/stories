class SearchController < ApplicationController
  def show
    @posts = Post.search(params[:search][:q]).records.to_a
    @users = User.search(params[:search][:q]).records.to_a
  end
end
