class AddSlugToTags < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :slug, :string
    add_index :tags, :slug, unique: true
  end
end
