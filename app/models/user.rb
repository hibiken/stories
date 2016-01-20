require 'elasticsearch/model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: { case_sensitive: false },
                       presence: true
  validate :avatar_image_size

  has_many :posts, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_responses, through: :likes, source: :likeable, source_type: "Response"

  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :bookmarkable, source_type: "Post"
  has_many :bookmarked_responses, through: :bookmarks, source: :bookmarkable, source_type: "Response"

  has_many :notifications, foreign_key: :recipient_id

  include UserFollowing
  include TagFollowing
  mount_uploader :avatar, AvatarUploader

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_commit :index_document, on: [:create, :update]
  after_commit :delete_document, on: [:destroy]

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :username, analyzer: 'english'
      indexes :email
    end
  end

  def self.search(term)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: term,
            fields: ['username^10', 'email']
          }
        }
      }
    )
  end

  def as_indexed_json(options ={})
    self.as_json({
      only: [:username, :email]
    })
  end



  def add_like_to(likeable_obj)
    likes.where(likeable: likeable_obj).first_or_create
  end

  def remove_like_from(likeable_obj)
    likes.where(likeable: likeable_obj).destroy_all
  end

  def liked?(likeable_obj)
    send("liked_#{downcased_class_name(likeable_obj)}_ids").include?(likeable_obj.id)
  end

  def add_bookmark_to(bookmarkable_obj)
    bookmarks.where(bookmarkable: bookmarkable_obj).first_or_create
  end

  def remove_bookmark_from(bookmarkable_obj)
    bookmarks.where(bookmarkable: bookmarkable_obj).destroy_all
  end

  def bookmarked?(bookmarkable_obj)
    send("bookmarked_#{downcased_class_name(bookmarkable_obj)}_ids").include?(bookmarkable_obj.id)
  end

  private

    # Validates the size on an uploaded image.
    def avatar_image_size
      if avatar.size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB")
      end
    end

    # Returns a string of the objects class name downcased.
    def downcased_class_name(obj)
      obj.class.to_s.downcase
    end

    def index_document
      UserIndexJob.perform_later('index', self.id)
    end

    def delete_document
      UserIndexJob.perform_later('delete', self.id)
    end
end


# Delete the previous users index in Elasticsearch
User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil

# Create the new index with the new mapping
User.__elasticsearch__.client.indices.create \
  index: User.index_name,
  body: { settings: User.settings.to_hash, mappings: User.mappings.to_hash }

# Index all user records from the DB to Elasticsearch
User.import
