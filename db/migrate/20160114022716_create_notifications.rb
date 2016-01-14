class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.string :action
      t.datetime :read_at
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps null: false
    end

    add_index :notifications, :recipient_id
    add_index :notifications, :actor_id
  end
end
