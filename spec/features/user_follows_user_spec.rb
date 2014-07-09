require 'rails_helper'

feature 'user follows another user' do
  scenario 'and sees the follow in his/her followed users' do
    usr_a = create(:user)
    usr_b = create(:user, username: "alexf", email: "af@example.com", password: "password")

    sign_in_as(usr_a)
    visit root_path
    click_link "Find User"
    fill_in "Find A User", with: usr_b.username
    click_button 'Go!'
    within(".row", text: usr_b.username) do
      click_button 'Follow'
    end
    click_link 'MyReaders'
    expect(page).to have_content usr_b.username
  end
end
