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

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, ->(number) { recent.limit(number) }
  scope :top_stories, ->(number) { order(likes_count: :desc).limit(number) }
  scope :published, -> { where.not(published_at: nil) }
  scope :drafts, -> { where(published_at: nil) }
  scope :featured, -> { where(featured: true) }

  mount_uploader :picture, PictureUploader

  before_save :generate_lead!
  # will_pagination configuration
  self.per_page = 5

  include SearchablePost

  def self.new_draft_for(user)
    post = self.new(user_id: user.id)
    post.save_as_draft
    post
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

  def publish
    self.published_at = Time.zone.now
    save
  end

  def save_as_draft
    self.published_at = nil
    save(validate: false)
  end

  def unpublish
    self.published_at = nil
  end

  def published?
    published_at.present?
  end

  def words
    body.split(' ')
  end

  def word_count
    words.size
  end

  # Generate a lead which appears in post panel.
  # FIXME: this method needs refactoring or completely different approach
  def generate_lead!
    if self.published?
      post_body = Nokogiri::HTML::Document.parse(self.body)
      if post_body.css('h2').size > 0
        self.lead = post_body.css('h2')[0].to_s
      elsif post_body.css('h3').size > 0
        self.lead = post_body.css('h3')[0].to_s
      elsif post_body.css('p').size > 0
        self.lead = post_body.css('p')[0].to_s
      end
    end
  end

end
