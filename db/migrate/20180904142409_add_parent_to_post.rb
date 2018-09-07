class AddParentToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :parent, index: true #, foreign_key: true
  end
end
