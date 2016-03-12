class GenerateLeadForPublishedPosts < ActiveRecord::Migration

  def change
    reversible do |dir|
      dir.up do
        Post.find_each do |post|
          post.generate_lead!
          post.save
        end
      end

      dir.down{ raise ActiveRecord::IrreversibleMigration }
    end
  end
end
