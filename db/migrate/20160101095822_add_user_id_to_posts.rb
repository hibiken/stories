class AddUserIdToPosts < ActiveRecord::Migration[4.2]
  def change
    add_reference :posts, :user, index: true, foreign_key: true
  end
end
