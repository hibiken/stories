# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  picture         :string
#  likes_count     :integer          default("0")
#  published_at    :datetime
#  featured        :boolean          default("false")
#  lead            :text
#  slug            :string
#  responses_count :integer          default("0"), not null
#

require "rails_helper"

RSpec.describe Post do
  describe "validations" do
    let(:post) { build(:post) }

    it "requires a title" do
      post.title = "   "
      expect(post).to be_invalid
    end

    it "requires a body" do
      post.body = "     "
      expect(post).to be_invalid
    end

    it "requires a user_id" do
      post.user_id = nil
      expect(post).to be_invalid
    end
  end

  describe "scopes" do
    let!(:post)  { create(:post) }
    let!(:draft) { create(:draft) }

    describe "published" do
      it "returns published posts" do
        posts = Post.published
        expect(posts).to include(post)
        expect(posts).not_to include(draft)
      end
    end

    describe "drafts" do
      it "returns drafts" do
        drafts = Post.drafts
        expect(drafts).to include(draft)
        expect(drafts).not_to include(post)
      end
    end
  end

  describe "::new_draft_for" do
    before(:each) do
      @user = create(:user)
    end

    it "creates and return a draft with user_id set to the given user" do
      draft = Post.new_draft_for(@user)
      expect(draft.user_id).to eq(@user.id)
      expect(draft.published_at).to be_nil
    end
  end

  describe "::tagged_with" do
    before(:each) do
      @music_tag = Tag.create!(name: "Music")
      @travel_tag = Tag.create!(name: "Travel")
      @music_post1 = create(:post)
      @music_post2 = create(:post)
      @travel_post = create(:post)

      @music_post1.tags << @music_tag
      @music_post2.tags << @music_tag
      @travel_post.tags << @travel_tag
    end

    it "returns posts with a given tag name" do
      posts = Post.tagged_with("Music")
      expect(posts).to match_array([@music_post1, @music_post2])
      expect(posts).not_to include(@travel_post)
    end
  end

  describe "#all_tags=, #all_tags" do
    before(:each) do
      @movies_tag = Tag.first_or_create_with_name!("Movies")
    end

    it "creates associations between this post and tags from a comma-separated string" do
      post = build(:post)
      post.all_tags = "Movies, Star Wars"
      post.save
      expect(post.tags.size).to eq(2)
      expect(post.tags).to include(@movies_tag)
    end
  end

  describe "#publish" do
    it "sets published_at and saves the record" do
      post = build(:draft)
      post.publish
      expect(post.published_at).to be_present
      expect(post).to be_persisted
    end

    it "sets appropriate slug when there are multiple posts with the same title" do
      post1 = build(:draft, title: "My favorite music")
      post1.publish
      expect(post1.slug).to eq('my-favorite-music')

      post2 = build(:draft, title: "My favorite music")
      post2.publish
      expect(post2).to be_persisted
      expect(post2.slug).not_to eq("my-favorite-music")
      expect(post2.slug).to match(/my-favorite-music/)
    end

    it "returns falsly value when it fails validations" do
      post = build(:draft, body: ' ')
      expect(post.publish).to be_falsy
    end
  end

  describe "#save_as_draft" do
    it "sets published_at to nil and saves the record" do
      post = build(:draft)
      post.save_as_draft
      expect(post.published_at).to be_nil
      expect(post).to be_persisted
    end
  end

  describe "words and word_count" do
    let(:post) { build(:post, body: "This is five words long.") }

    it "returns an array of words" do
      expect(post.words).to include("five")
      expect(post.words.first).to eq("This")
    end

    it "returns the word count" do
      expect(post.word_count).to eq(5)
    end
  end

  describe "#generate_lead" do
    let(:post1) { build(:post, body: "<p>this is a simple content.</p>") }
    let(:post2) { build(:post, body: "<p><span>this is more complicated content</span></p>") }
    let(:post3) { build(:post, body: "<h2>Subtitle</h2><span>hello world</span><p>cool</p>") }

    it "generate lead for published posts" do
      post1.generate_lead!
      post2.generate_lead!
      post3.generate_lead!

      expect(post1.lead).to eq("<p>this is a simple content.</p>")
      expect(post2.lead).to eq("<p><span>this is more complicated content</span></p>")
      expect(post3.lead).to eq("<h2>Subtitle</h2>\n")
    end
  end
end
