class AddCounterToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :likes_count, :integer, default: 0
    add_column :responses, :likes_count, :integer, default: 0

    Like.destroy_all
  end
end
