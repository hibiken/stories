class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.json :photos

      t.timestamps null: false
    end
  end
end
