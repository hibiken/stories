class API::SearchAutocompleteController < ApplicationController
  def index
    results = Elasticsearch::Model.search(params[:term], [Post, User, Tag])
    @posts = results.select { |result| result["_type"] == 'post' }
    @users = results.select { |result| result["_type"] == 'user' }
    @tags  = results.select { |result| result["_type"] == 'tag' }
  end
end
