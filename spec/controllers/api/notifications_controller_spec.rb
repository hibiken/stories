require "rails_helper"

RSpec.describe API::NotificationsController do

  let(:luke) { create(:user, username: "Luke") }
  let(:solo) { create(:user, username: "Solo") }
  let(:lukes_post1) { create(:post, user: luke) }
  let(:lukes_post2) { create(:post, user: luke) }

  describe "POST #mark_as_touched" do
    before :each do
      @notification = Notification.create(recipient: solo,
                                          actor: luke,
                                          action: "liked your",
                                          notifiable: lukes_post1,
                                          is_new: true)
      login solo
    end

    it "sets is_new field to false" do
      post :mark_as_touched
      @notification.reload
      expect(@notification.is_new).to be_falsy
    end
  end

  describe "POST #mark_as_read" do
    before :each do
      @notification1 = Notification.create(recipient: solo,
                                          actor: luke,
                                          action: "liked your",
                                          notifiable: lukes_post1,
                                          is_new: true)

      @notification2 = Notification.create(recipient: solo,
                                          actor: luke,
                                          action: "liked your",
                                          notifiable: lukes_post2,
                                          is_new: true)
      login solo
    end

    it "sets read_at timestamp" do
      post :mark_as_read, id: @notification1.id
      @notification1.reload
      @notification2.reload
      expect(@notification1.read_at).not_to be_nil
      expect(@notification2.read_at).to be_nil
    end
  end

  describe "POST #mark_all_as_read" do
    before :each do
      @notification1 = Notification.create(recipient: solo,
                                          actor: luke,
                                          action: "liked your",
                                          notifiable: lukes_post1,
                                          is_new: true)

      @notification2 = Notification.create(recipient: solo,
                                          actor: luke,
                                          action: "liked your",
                                          notifiable: lukes_post2,
                                          is_new: true)
      login solo
    end

    it "sets read_at timestamp" do
      post :mark_all_as_read
      @notification1.reload
      @notification2.reload
      expect(@notification1.read_at).not_to be_nil
      expect(@notification2.read_at).not_to be_nil
    end
  end
end
