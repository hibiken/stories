# == Schema Information
#
# Table name: interests
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  tag_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Interest < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :tag

  validates :follower_id, presence: true
  validates :tag_id, presence: true
end
