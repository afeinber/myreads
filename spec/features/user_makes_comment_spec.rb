require 'rails_helper'

feature 'user makes a comment' do
  scenario 'successfully' do
    @books = create_list(:book, 5)
    visit root_path
    usr = create(:user)
    sign_in_as(usr)
    click_link @books.first.title

    fill_in "Post a Comment", with: "Worst toilet paper ever"
    click_button 'Post'

    within(".comment", text: usr.username) do
      expect(page).to have_content "Worst toilet paper ever"
    end


  end
end
