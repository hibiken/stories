class API::SearchAutocompleteController < ApplicationController
  def index
    @posts = Post.search(params[:term])
    @users = User.search(params[:term])
    @tags  = Tag.search(params[:term])
  end
end
