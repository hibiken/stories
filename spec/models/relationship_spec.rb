require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "validations" do
    let(:relationship) { Relationship.new(follower_id: 1, followed_id: 2) }

    it "is valid with both follower and followed ids" do
      expect(relationship).to be_valid
    end

    it "is invalid without follower_id" do
      relationship.follower_id = nil
      expect(relationship).to be_invalid
    end

    it "is invalid without followed_id" do
      relationship.followed_id = nil
      expect(relationship).to be_invalid
    end
  end
end
