# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  recipient_id    :integer
#  actor_id        :integer
#  action          :string
#  read_at         :datetime
#  notifiable_id   :integer
#  notifiable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_new          :boolean          default("false")
#

class Notification < ActiveRecord::Base
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :pristine, -> { where(is_new: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }
end
