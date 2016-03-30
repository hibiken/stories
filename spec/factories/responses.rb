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

FactoryGirl.define do
  factory :response do
    body "Awesome post thanks!!"
    user
  end
end
