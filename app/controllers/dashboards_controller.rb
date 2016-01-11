class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:bookmarks]
  def show
    if user_signed_in?
      @dashboard = Dashboard.new(user: current_user)
    else
      @dashboard = Dashboard.new
    end
  end

  def bookmarks
    @dashboard = Dashboard.new(user: current_user, filter: :bookmarks)
    render :show
  end

end
