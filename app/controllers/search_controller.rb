class SearchController < ApplicationController
  def search
    @search_results = Elasticsearch::Model.search(params[:search][:q], [Post, User]).records.to_a
  end
end
