require 'rails_helper'

feature 'user makes a comment' do
  scenario 'successfully' do
    visit root_path
    user = create(:user)
    sign_in_as(user)
    visit root_path
    fill_in "Search", with: "Harry Potter"
    click_button 'Search'

    click_link "Harry Potter and the Sorcerer's Stone"

    fill_in "Post a Comment", with: "Worst toilet paper ever"
    click_button 'Post'

    within(".comment", text: user.username) do
      expect(page).to have_content "Worst toilet paper ever"
    end


  end
end
