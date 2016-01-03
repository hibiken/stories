require "rails_helper"

RSpec.describe PostsHelper do

  describe "#post_length_in_minutes" do
    it "calculates the time to read an article" do
      five_hundred_words = "word " * 500
      actual = helper.post_length_in_minutes(five_hundred_words)
      expect(actual).to eq("2 min read")
    end

    it "can handle really short post" do
      less_than_one_hundred = "word " * 90
      actual = helper.post_length_in_minutes(less_than_one_hundred)
      expect(actual).to eq("less than a minute read")
    end
  end
end
