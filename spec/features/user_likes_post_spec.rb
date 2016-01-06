require "rails_helper"

RSpec.feature "Liking a post" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "signed-in user likes a post successfully" do
    sign_in user
    visit post_path(post)
    click_on "Like"
    expect(page).to have_content "1"
  end
end
