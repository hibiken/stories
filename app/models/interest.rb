class Interest < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :tag

  validates :follower_id, presence: true
  validates :tag_id, presence: true
end
