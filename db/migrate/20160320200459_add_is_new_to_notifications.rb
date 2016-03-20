class AddIsNewToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :is_new, :boolean, default: false
  end
end
