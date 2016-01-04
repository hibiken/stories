class Post < ActiveRecord::Base

  validates :title, :body, :user_id, presence: true

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  delegate :username, to: :user

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end
end
