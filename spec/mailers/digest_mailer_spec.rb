require "rails_helper"

RSpec.describe DigestMailer, type: :mailer do
  describe "daily_email" do
    let(:user) { create(:user) }
    let(:mail) { DigestMailer.daily_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Stories Daily Digest")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ENV['MAILER_SENDER'] || "stories@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Daily Digest")
    end
  end

end
