require 'rails_helper'



feature 'user views an individual book' do

  background do
    @books = create_list(:book, 5)
    visit root_path
  end

  scenario "and sees that book's attributes" do

    click_link @books.first.title
    expect(page).to have_content @books.first.published_on
  end

  scenario 'and sees the books comments' do
    usr = create(:user)
    cmnt = Comment.create(user: usr, book: @books.first, content: 'Terrible. All in comic sans!')
    click_link @books.first.title

    expect(page).to have_content 'Terrible. All in comic sans!'
  end
end
