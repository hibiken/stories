class AddPictureToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :picture, :string
  end
end
