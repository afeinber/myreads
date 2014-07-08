require 'rails_helper'

feature 'user views users' do
  scenario 'on the find users page' do
    alex = User.create(username:'Alex', email: 'alex@example.com', password: 'password')

    visit root_path
    click_link 'Find User'

    fill_in 'Find A User', with: 'Alex'
    click_button 'Go!'

    within('.user', text: 'Alex') do
      expect(page).to have_content 'alex@example.com'
    end
  end
end
