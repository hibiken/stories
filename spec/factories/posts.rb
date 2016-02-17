FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Awesome post No.#{n}" }
    body "Here are some awesome content" 
    published_at Time.zone.now
    user

    factory :draft do
      published_at nil
    end
  end
end
