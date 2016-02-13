require "rails_helper"

RSpec.describe Dashboard do
  context "dashboard with current_user" do

    before(:each) do
      @current_user = instance_double("User", :nil? => false)
      @dashboard = Dashboard.new(user: @current_user)
    end

    describe "#following_tags" do
      it "delegates following_tags to user object" do
        allow(@current_user).to receive(:following_tags)

        @dashboard.following_tags
        expect(@current_user).to have_received(:following_tags)
      end
    end
  end

  context "dashboard with current_user and bookmarks filter" do

    before(:each) do
      @current_user = instance_double("User", :nil? => false)
      @dashboard = Dashboard.new(user: @current_user, filter: :bookmarks)
    end

    describe "#filtered_posts" do
      it "sends bookmarked_posts to user object" do
        allow(@current_user).to receive(:bookmarked_posts)

        @dashboard.filtered_posts
        expect(@current_user).to have_received(:bookmarked_posts)
      end
    end
  end

  context "dashboard with current_user and top_stories filter" do

    before(:each) do
      @current_user = instance_double("User", :nil? => false)
      @dashboard = Dashboard.new(user: @current_user, filter: :top_stories)
    end

    describe "#filtered_posts" do
      it "sends top_stories message to Post" do
        allow(Post).to receive(:top_stories).with(5)

        @dashboard.filtered_posts
        expect(Post).to have_received(:top_stories)
      end
    end
  end



end
