# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  body        :text
#  post_id     :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default("0")
#

require 'rails_helper'

RSpec.describe Response, type: :model do
  describe "validations" do
    let(:response) { Response.new(user_id: 1, post_id: 2, body: "Great post!") }

    it "is valid with both user_id and post_id and body" do
      expect(response).to be_valid
    end

    it "is invalid without body" do
      response.body = "   "
      expect(response).to be_invalid
    end

    it "is invalid without user_id" do
      response.user_id = nil
      expect(response).to be_invalid
    end

    it "is invalid without post_id" do
      response.post_id = nil
      expect(response).to be_invalid
    end
  end
end
