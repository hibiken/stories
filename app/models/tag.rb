class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  has_many :interests, dependent: :destroy
  has_many :followers, through: :interests, source: :follower

  include SearchableTag
end

# Delete the previous posts index in Elasticsearch
Tag.__elasticsearch__.client.indices.delete index: Tag.index_name rescue nil

# Create the new index with the new mapping
Tag.__elasticsearch__.client.indices.create \
  index: Tag.index_name,
  body: { settings: Tag.settings.to_hash, mappings: Tag.mappings.to_hash }

# Index all post records from the DB to Elasticsearch
Tag.import
