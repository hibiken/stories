FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Awesome post No.#{n}" }
    body "Here are some awesome content" 
  end
end
