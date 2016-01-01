class Post < ActiveRecord::Base

  belongs_to :user

  delegate :username, to: :user
end
