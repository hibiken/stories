class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @dashboard = Dashboard.new(user: current_user, filter: params[:filter])
  end

end
