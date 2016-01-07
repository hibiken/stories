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

  include UserFollowing
  include TagFollowing
  mount_uploader :avatar, AvatarUploader

  def add_like_to(post)
    likes.create(likeable: post)
  end

  def remove_like_from(post)
    likes.find_by(likeable: post).destroy
  end

  def likes?(post)
    liked_post_ids.include?(post.id)
  end

  private

    # Validates the size on an uploaded image.
    def avatar_image_size
      if avatar.size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB")
      end
    end
end
