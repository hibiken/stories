class AddFeaturedToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :featured, :boolean, default: false
  end
end
