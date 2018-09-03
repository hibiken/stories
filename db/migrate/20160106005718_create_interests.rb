class CreateInterests < ActiveRecord::Migration[4.2]
  def change
    create_table :interests do |t|
      t.integer :follower_id
      t.integer :tag_id

      t.timestamps null: false
    end

    add_index :interests, :follower_id
    add_index :interests, :tag_id
    add_index :interests, [:follower_id, :tag_id], unique: true
  end
end
