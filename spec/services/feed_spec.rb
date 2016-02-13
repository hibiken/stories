require "rails_helper"

RSpec.describe Feed do
  let(:current_user) { create(:user) }
  let!(:followed_user) { create(:user, username: "Followed User") }
  let!(:not_followed_user) { create(:user, username: "Not followed user") }
  let!(:stranger) { create(:user) }
  let!(:followed_post) { create(:post, user: followed_user, title: "Followed this user") }
  let!(:not_followed_post) { create(:post, user: not_followed_user, title: "not following") }
  let!(:music_tag) { Tag.create!(name: "Music") }
  let!(:travel_tag) { Tag.create!(name: "Travel") }
  let!(:music_post) { create(:post, user: stranger, title: "Music Post") }
  let!(:travel_post) { create(:post, user: stranger, title: "Travel Post") }
  let!(:liked_by_following) { create(:post, title: "Liked by following") }

  let(:feed) { Feed.new(current_user) }

  before(:example) do
    current_user.follow_tag(music_tag)
    current_user.follow(followed_user)
    music_post.tags << music_tag
    travel_post.tags << travel_tag
    followed_user.add_like_to(liked_by_following)
  end

  describe "#posts" do
    it "includes posts which user either follow the author or the tag" do
      expect(feed.posts).to include(followed_post, music_post, liked_by_following)
      expect(feed.posts).not_to include(not_followed_post, travel_post)
    end
  end

  describe "#tagged?" do
    it "returns boolean depending on a given post is included in feed because of tagging" do
      expect(feed.tagged?(music_post)).to be_truthy
      expect(feed.tagged?(travel_post)).to be_falsy
      expect(feed.tagged?(followed_post)).to be_falsy
    end
  end

  describe "#following_author?" do
    it "returns boolean depending on a given post is published by a following user" do
      expect(feed.following_author?(followed_post)).to be_truthy
      expect(feed.following_author?(not_followed_post)).to be_falsy
      expect(feed.following_author?(music_post)).to be_falsy
    end
  end

  describe "#recommended?" do
    it "returns boolean depending on a given post is recommended by a following user" do
      expect(feed.recommended?(liked_by_following)).to be_truthy
      expect(feed.recommended?(music_post)).to be_falsy
    end
  end

  describe "#tag_for" do
    it "returns the tag name given a post that has a tag which current_user follows" do
      expect(feed.tag_for(music_post)).to eq(music_tag)
      expect(feed.tag_for(travel_post)).to be_nil
    end
  end

  describe "#recommender_for(post)" do
    it "returns a recommender given a post" do
      expect(feed.recommender_for(liked_by_following)).to eq(followed_user)
    end
  end
end
