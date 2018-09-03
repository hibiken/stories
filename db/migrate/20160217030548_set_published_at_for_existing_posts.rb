class SetPublishedAtForExistingPosts < ActiveRecord::Migration[4.2]
  class Post < ActiveRecord::Base
  end

  def change
    reversible do |dir|
      dir.up do
        Post.find_each do |post|
          post.published_at = post.created_at
          post.save!
        end
      end

      dir.down { raise ActiveRecord::IrreversibleMigration }
    end
  end
end
