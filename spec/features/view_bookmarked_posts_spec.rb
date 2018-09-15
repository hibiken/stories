require "rails_helper"

RSpec.feature "Viewing bookmarked posts" do
  let(:user) { create(:user) }
  let(:body){
    '{"blocks":[{"key":"a3rc6","text":"Interesting post","type":"unstyled","depth":0,"inlineStyleRanges":[],"entityRanges":[],"data":{}}],"entityMap":{}}'
  }

  let(:body2){
    '{"blocks":[{"key":"a3rc6","text":"Not so interesting post","type":"unstyled","depth":0,"inlineStyleRanges":[],"entityRanges":[],"data":{}}],"entityMap":{}}'
  }

  let!(:post_1) { create(:post, body: body, plain: 'Interesting post' ) }
  let!(:post_2) { create(:post, body: body2, plain: 'Not so interesting post' ) }

  background do
    user.add_bookmark_to(post_1)
  end

  scenario "Signed in user can view his/hew bookmarked post in bookmark page", js: true do
    sign_in user
    visit root_path
    click_on "Bookmarks"
    expect(page).to have_link "Interesting post"
    expect(page).not_to have_link "Not so interesting post"
  end

  scenario "non-logged in user cannot go to bookmarked post page", js: true do
    visit root_path
    click_on "Bookmarks"
    expect(page).to have_content("Sign in with Facebook")
  end
end
