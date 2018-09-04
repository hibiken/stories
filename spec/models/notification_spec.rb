# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  recipient_id    :integer
#  actor_id        :integer
#  action          :string
#  read_at         :datetime
#  notifiable_id   :integer
#  notifiable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_new          :boolean          default("false")
#

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "scopes" do
    before :each do
      user1 = create(:user)
      user2 = create(:user)
      post = create(:post)
      
      @new_notification1 = create(:notification, created_at: 2.days.ago, recipient: user2, actor: user1, notifiable: post)
      @new_notification2 = create(:notification, created_at: 3.hours.ago, recipient: user2, actor: user1, notifiable: post)
      @touched_notification = create(:touched_notification, created_at: 5.days.ago, recipient: user2, actor: user1, notifiable: post)
      @read_notification = create(:read_notification, created_at: 10.days.ago, recipient: user2, actor: user1, notifiable: post)
    end

    describe "#pristine" do
      it "returns the notifications that user hasn't touched" do
        expect(Notification.pristine).to match_array([@new_notification1, @new_notification2])
      end
    end

    describe "#recent" do
      it "returns notifications in order based on created_at field" do
        expect(Notification.recent).to eq([@new_notification2, @new_notification1, @touched_notification, @read_notification])
      end
    end

    describe "#unread" do
      it "returns only unread notifications" do
        expect(Notification.unread).not_to include(@read_notification)
        expect(Notification.unread.count).to eq(3)
      end
    end
  end
end
