# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  body        :text
#  post_id     :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default("0")
#

class Response < ActiveRecord::Base
  validates :body, presence: true
  validates :post_id, :user_id, presence: true

  belongs_to :post, counter_cache: true
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  has_many :bookmarks, as: :bookmarkable
  has_many :bookmarkers, through: :bookmarks, source: :user

  delegate :username, to: :user
end
