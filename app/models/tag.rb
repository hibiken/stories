# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured       :boolean          default("false")
#  slug           :string
#  lowercase_name :string
#

class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  has_many :interests, dependent: :destroy
  has_many :followers, through: :interests, source: :follower

  has_many :tag_relationships, -> { order(relevance: :desc) }, dependent: :destroy
  has_many :related_tags, through: :tag_relationships, source: :related_tag

  validates :name, presence: true

  include SearchableTag

  extend FriendlyId
  friendly_id :name, use: [ :slugged, :finders ]

  def self.first_or_create_with_name!(name)
    where(lowercase_name: name.strip.downcase).first_or_create! do |tag|
      tag.name = name.strip
    end
  end
end
