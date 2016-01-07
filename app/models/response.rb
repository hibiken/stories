class Response < ActiveRecord::Base
  validates :body, presence: true
  validates :post_id, :user_id, presence: true

  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  delegate :username, to: :user
end
