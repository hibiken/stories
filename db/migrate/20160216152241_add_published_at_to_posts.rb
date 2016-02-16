class AddPublishedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published_at, :datetime
  end
end
