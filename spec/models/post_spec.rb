require "rails_helper"

RSpec.describe Post do
  describe "#publish" do
    it "sets published_at and saves the record" do
      post = build(:post)
      post.publish
      expect(post.published_at).to be_present
      expect(post).to be_persisted
    end
  end

  describe "#save_as_draft" do
    it "sets published_at to nil and saves the record" do
      post = build(:post)
      post.save_as_draft
      expect(post.published_at).to be_nil
      expect(post).to be_persisted
    end
  end
end
