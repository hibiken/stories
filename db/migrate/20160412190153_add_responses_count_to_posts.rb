class AddResponsesCountToPosts < ActiveRecord::Migration[4.2]
  def up
    add_column :posts, :responses_count, :integer, null: false, default: 0
    # reset cached counts for posts with responses
    #ids = Set.new
    #Post.replies.all.find_each { |r| ids << r.parent_id }
    #ids.each do |post_id|
    #  Post.reset_counters(post_id, :responses)
    #end
  end

  def down
    remove_column :posts, :responses_count
  end
end
