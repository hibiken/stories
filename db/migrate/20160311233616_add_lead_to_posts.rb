class AddLeadToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :lead, :text
  end
end
