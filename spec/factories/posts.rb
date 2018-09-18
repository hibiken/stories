# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  picture         :string
#  likes_count     :integer          default("0")
#  published_at    :datetime
#  featured        :boolean          default("false")
#  lead            :text
#  slug            :string
#  responses_count :integer          default("0"), not null
#

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Awesome post No.#{n}" }
    body { '{"blocks":[{"key":"a3rc6","text":"hello world","type":"unstyled","depth":0,"inlineStyleRanges":[],"entityRanges":[],"data":{}}],"entityMap":{}}' }
    plain { 'hello world'}
    published_at {Time.zone.now}
    user

    factory :draft do
      published_at {nil}
    end
  end
end
