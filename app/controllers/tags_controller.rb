class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @dashboard = Dashboard.new(user: current_user, tag: @tag)
    render 'dashboards/show'
  end
end
