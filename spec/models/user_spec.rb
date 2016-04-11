# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  description            :text
#  avatar                 :string
#  provider               :string
#  uid                    :string
#  slug                   :string
#  location               :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
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

  describe "relationships between users" do
    let(:luke) { create(:user, username: "Luke Skywalker") }
    let(:solo) { create(:user, username: "Han Solo") }

    it "can follow and unfollow other users" do
      expect(luke).not_to be_following(solo)

      luke.follow(solo)
      expect(luke).to be_following(solo)
      expect(solo.followers).to include(luke)

      luke.unfollow(solo)
      expect(luke).not_to be_following(solo)
      expect(solo.followers).not_to include(luke)
    end

    it "returns false when asked whether a user is following self" do
      expect(luke.following?(luke)).to be_falsy
    end

    it "does not allow to follow self" do
      expect { luke.follow(luke) }.not_to change { Relationship.count }
      expect(luke.follow(luke)).to be_falsy
    end
  end

  describe "user interests" do
    let(:user) { create(:user) }
    let(:music_tag) { Tag.create(name: "Music") }

    it "can follow and unfollow a tag" do
      expect(user).not_to be_following_tag(music_tag)

      user.follow_tag(music_tag)
      expect(user).to be_following_tag(music_tag)

      user.unfollow_tag(music_tag)
      expect(user).not_to be_following_tag(music_tag)
    end
  end

  describe "adding likes" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:response) { build(:response) }
    before :each do
      post.responses << response
    end

    it "can like and unlike a post" do
      user.add_like_to(post)
      expect(user.liked?(post)).to be_truthy

      user.remove_like_from(post)
      expect(user.liked?(post)).to be_falsy
    end

    it "can like and unlike a response" do
      user.add_like_to(response)
      expect(user.liked?(response)).to be_truthy

      user.remove_like_from(response)
      expect(user.liked?(response)).to be_falsy
    end
  end

  describe "adding bookmarks" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:response) { build(:response) }
    before :each do
      post.responses << response
    end

    it "can bookmark and unbookmark a post" do
      user.add_bookmark_to(post)
      expect(user.bookmarked?(post)).to be_truthy

      user.remove_bookmark_from(post)
      expect(user.bookmarked?(post)).to be_falsy
    end

    it "can bookmark and unbookmark a response" do
      user.add_bookmark_to(response)
      expect(user.bookmarked?(response)).to be_truthy

      user.remove_bookmark_from(response)
      expect(user.bookmarked?(response)).to be_falsy
    end
  end

  # TODO: this is a temporary implemention, change this when the number of user
  # grows.
  describe "#people_to_folow" do
    let(:user) { create(:user) }

    it "gets upto 25 users not including self"
  end
end
