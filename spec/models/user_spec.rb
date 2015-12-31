require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires a unique username" do
      user1 = create(:user, username: 'exampleuser')
      user2 = build(:user, username: 'exampleuser')
      user2.valid?
      expect(user2.errors[:username]).to include('has already been taken')
    end

    it "requires a username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end
  end
end
