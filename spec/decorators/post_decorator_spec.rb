require "rails_helper"

RSpec.describe PostDecorator do
  let(:current_user) { create(:user) }
  let(:recommender) { create(:user, username: "Recommender") }
  let(:travel_tag) { Tag.first_or_create_with_name!("travel") }
  let(:post) { create(:post, title: "My Title")}
  let(:instance) { PostDecorator.new(post, current_user) }

  it "responds to title, body" do
    expect(instance.title).to eq("My Title")
  end

  context "with current_user following a tag" do
    before(:each) do
      post.tags << travel_tag
      current_user.follow_tag(travel_tag)
    end

    it "knows the tagging" do
      expect(instance).to be_tagged
    end

    it "knows which tag" do
      expect(instance.tag.name).to eq travel_tag.name
    end
  end

  context "with a recommender" do
    before(:each) do
      current_user.follow(recommender)
      recommender.add_like_to(post)
    end

    it "knows if it's recommended" do
      expect(instance).to be_recommended
    end

    it "knows recommender" do
      expect(instance.recommender.username).to eq(recommender.username)
    end
  end
end
