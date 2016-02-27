class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new(posts: all_posts)
  end

  private

    def all_posts
      Post.published
    end
end
