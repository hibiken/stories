class AddLeadToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :lead, :text
  end
end
