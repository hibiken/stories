class DeviseCreateAdmins < ActiveRecord::Migration[4.2]
  def change
    create_table(:admins) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.timestamps null: false
    end

    add_index :admins, :email,                unique: true
  end
end
