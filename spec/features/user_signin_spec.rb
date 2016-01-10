require "rails_helper"

feature "User signs in" do
  scenario "successfully" do
    user = create(:user, username: 'exampleuser')
    sign_in user
    expect(page).to have_content 'Sign out'
    expect(current_path).to eq(root_path)
  end
end
