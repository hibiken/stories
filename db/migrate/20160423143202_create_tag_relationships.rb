class CreateTagRelationships < ActiveRecord::Migration
  def change
    create_table :tag_relationships do |t|
      t.integer :tag_id, null: false
      t.integer :related_tag_id, null: false
      t.integer :relevance, default: 0, null: false

      t.timestamps null: false
    end

    add_index :tag_relationships, :tag_id
    add_index :tag_relationships, :related_tag_id
    add_index :tag_relationships, [:tag_id, :related_tag_id], unique: true
  end
end
