class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps null: false
    end

    add_index :tags, :name
  end
end
