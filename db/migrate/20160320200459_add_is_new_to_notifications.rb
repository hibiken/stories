class AddIsNewToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :is_new, :boolean, default: false
  end
end
