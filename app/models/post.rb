class Post < ActiveRecord::Base

  validates :title, :body, :user_id, presence: true

  belongs_to :user

  delegate :username, to: :user
end
