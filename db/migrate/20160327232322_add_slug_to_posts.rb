class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
  end
end
