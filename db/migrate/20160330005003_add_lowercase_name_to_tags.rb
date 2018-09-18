class AddLowercaseNameToTags < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :lowercase_name, :string
  end
end
