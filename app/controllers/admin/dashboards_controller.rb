class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new
  end
end
