class AddFeaturedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :boolean, default: false
  end
end
