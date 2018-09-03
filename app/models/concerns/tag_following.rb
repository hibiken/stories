module TagFollowing
  extend ActiveSupport::Concern

  included do
    has_many :interests, foreign_key: "follower_id",
                         dependent: :destroy
    has_many :following_tags, through: :interests, source: :tag
  end

  def follow_tag(tag)
    interests.create(tag_id: tag.id)
  end

  def unfollow_tag(tag)
    interests.find_by(tag_id: tag.id).destroy
  end

  def following_tag?(tag)
    following_tag_ids.include?(tag.id)
  end

end
