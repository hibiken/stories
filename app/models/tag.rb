class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  has_many :interests, dependent: :destroy
  has_many :followers, through: :interests, source: :follower
end
