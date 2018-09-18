class SearchController < ApplicationController
  before_action :beautify_url
  layout "simple"

  def show
    @post_records = Post.search(query_term, page: params[:page], per_page: 20 ) #.paginate(page: params[:page]).records
    @posts = @post_records.to_a.select { |post| post.published? }
    @users = User.search(query_term).results.to_a
    @tags = Tag.search(query_term).results
  end

  def users
    @users = User.search(query_term).results #.to_a
  end

  private

    def beautify_url
      if params[:search].present?
        case params[:action]
        when "show"
          redirect_to search_url(q: params[:search][:q])
        when "users"
          redirect_to search_users_url(q: params[:search][:q])
        end
      end
    end

    def query_term
      params[:q] || ''
    end
end
