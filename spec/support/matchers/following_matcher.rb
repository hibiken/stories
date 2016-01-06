require 'rspec/expectations'

RSpec::Matchers.define :be_following do |other_user|
  match do |user|
    user.following?(other_user)
  end

  description do
    "be following #{other_user.username}"
  end

  failure_message do |user|
    "expected #{user.username} to be following #{other_user.username}"
  end

  failure_message_when_negated do |user|
    "expected #{user.username} not to be following #{other_user.username}"
  end
end

RSpec::Matchers.define :be_following_tag do |tag|
  match do |user|
    user.following_tag?(tag)
  end

  description do
    "be following a tag: #{tag.name}"
  end

  failure_message do |user|
    "expected #{user.username} to be following a tag #{tag.name}"
  end

  failure_message_when_negated do |user|
    "expected #{user.username} not to be following a tag #{tag.name}"
  end
end
