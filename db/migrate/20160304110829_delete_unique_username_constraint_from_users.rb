class DeleteUniqueUsernameConstraintFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_index :users, :username
  end
end
