# == Schema Information
#
# Table name: interests
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  tag_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Interest, type: :model do
  describe "validations" do
    let(:interest) { Interest.new(follower_id: 1, tag_id: 2) }

    it "is valid with both follower and tag ids" do
      expect(interest).to be_valid
    end

    it "is invalid without follower_id" do
      interest.follower_id = nil
      expect(interest).to be_invalid
    end

    it "is invalid without tag_id" do
      interest.tag_id = nil
      expect(interest).to be_invalid
    end
  end
end
