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

    #it "requires avatar image to be less than 5MB in size" do
    #  uploaded_image = double('avatar image', size: 6.megabytes)
    #  user = build(:user, avatar: uploaded_image)
    #  user.valid?
    #  expect(user.errors[:avatar]).to include('should be less than 5MB')
    #end
  end
end
