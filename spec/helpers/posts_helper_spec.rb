require "rails_helper"

RSpec.describe PostsHelper do

  describe "#post_length_in_minutes" do
    let(:post) { build_stubbed(:post) }

    it "calculates the time to read an article" do
      five_hundred_words = "word " * 500
      post.body = five_hundred_words
      actual = helper.post_length_in_minutes(post.body)
      expect(actual).to eq("2 min read")
    end

    it "can handle really short post" do
      post.body = "word " * 90
      actual = helper.post_length_in_minutes(post.body)
      expect(actual).to eq("less than a minute")
    end
  end
end
