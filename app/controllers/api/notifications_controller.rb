class API::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).recent.paginate(page: params[:page], per_page: 7)
    @new_notification_count = Notification.where(recipient: current_user, is_new: true).count
  end

  def mark_as_touched
    notifications = Notification.where(recipient: current_user).pristine
    notifications.update_all(is_new: false)
    render nothing: true, status: 204
  end

  def mark_all_as_read
    notifications = Notification.where(recipient: current_user).unread
    notifications.update_all(read_at: Time.zone.now)
    render nothing: true, status: 204
  end

  def mark_as_read
    notification = Notification.find_by(id: params[:id], recipient: current_user)
    notification.update(read_at: Time.zone.now)
    render nothing: true, status: 204
  end
end
