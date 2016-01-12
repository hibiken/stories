class Admin::DashboardsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def show

  end
end
