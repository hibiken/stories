require 'elasticsearch/model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]
  validates :username, presence: true
  validate :avatar_image_size

  has_many :posts, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_responses, through: :likes, source: :likeable, source_type: "Response"

  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :bookmarkable, source_type: "Post"
  has_many :bookmarked_responses, through: :bookmarks, source: :bookmarkable, source_type: "Response"

  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id

  after_destroy :clear_notifications
  after_commit :send_welcome_email, on: [:create]

  include UserFollowing
  include TagFollowing
  mount_uploader :avatar, AvatarUploader

  include SearchableUser
  include OmniauthableUser

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

    # Clears notifications where deleted user is the actor.
    def clear_notifications
      Notification.where(actor_id: self.id).destroy_all
    end

    def send_welcome_email
      WelcomeEmailJob.perform_later(self.id)
    end
end
