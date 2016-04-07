module UserFollowing
  extend ActiveSupport::Concern

  included do
    # Followings
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    # Followers
    has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower
  end

  def follow(other_user)
    return false if self.id == other_user.id
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following_ids.include?(other_user.id)
  end

  def people_to_follow
    User.where.not(id: following_ids + [self.id]).limit(25).order("RANDOM()")
  end
end
