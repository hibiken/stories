class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:bookmarks]
  def show
    @dashboard = Dashboard.new(user: current_user)
  end

  def bookmarks
    @dashboard = Dashboard.new(user: current_user, filter: :bookmarks)
    render :show
  end

end
