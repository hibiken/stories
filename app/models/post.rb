require 'elasticsearch/model'

class Post < ActiveRecord::Base

  validates :title, :body, :user_id, presence: true

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :responses, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :responders, through: :responses, source: :user
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  has_many :bookmarks, as: :bookmarkable
  has_many :bookmarkers, through: :bookmarks, source: :user

  delegate :username, to: :user

  default_scope { order(created_at: :desc) }
  scope :latest, ->(number) { order(created_at: :desc).limit(number) }
  scope :top_stories, ->(number) { order(:likes_count).limit(number) }

  mount_uploader :picture, PictureUploader

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :body, analyzer: 'english'
      indexes :tags do
        indexes :name, analyzer: 'english'
      end
      indexes :user do
        indexes :username, analyzer: 'english'
      end
    end
  end

  def self.search(term)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: term,
            fields: ['title^10', 'body', 'user.username^5', 'tags.name^5']
          }
        }
      }
    )
  end

  def as_indexed_json(options = {})
    self.as_json({
      only: [:title, :body],
      include: {
        user: { only: :username },
        tags: { only: :name }
      }
    })
  end

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

# Delete the previous posts index in Elasticsearch
Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

# Create the new index with the new mapping
Post.__elasticsearch__.client.indices.create \
  index: Post.index_name,
  body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }

# Index all post records from the DB to Elasticsearch
Post.import
