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

FactoryBot.define do
  factory :notification do
    #recipient {user}
    #actor {user}
    action {"responded to your"}
    read_at {nil}
    #notifiable {post}
    is_new {true}

    factory :touched_notification do
      is_new {false}
    end

    factory :read_notification do
      is_new {false}
      read_at {1.day.ago}
    end
  end
end
