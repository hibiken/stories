class CreateResponses < ActiveRecord::Migration[4.2]
  def change
    create_table :responses do |t|
      t.text :body
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
