require 'rails_helper'

feature 'user requests a follow' do
  scenario 'successfully' do
    user_a = create(:user)
    user_b = create(:user, username: 'userb', email: 'userb@example.com')

    visit root_path
    sign_in_as(user_a)
    click_link 'Find User'
    fill_in 'Find A User', with: user_b.username
    click_button 'Go!'
    click_button 'Follow'
    click_link user_b.username
    click_button "Following"
    click_link "Request Follow"
    click_link user_a.username
    click_link "Logout"
    sign_in_as(user_b)
    click_link "MyMessages"
    expect(page).to have_content user_a.username

  end
end
