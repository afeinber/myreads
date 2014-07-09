require 'rails_helper'

feature 'user adds book' do

  background do
    @books = []
    res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium'})
    res.items.each do |item|
      authors = []
      @books << new_book = Book.create!(
        photo: item.get_hash('LargeImage')["URL"],
        title: item.get('ItemAttributes/Title'),
        published_on: item.get('ItemAttributes/PublicationDate'),
        asin: item.get('ASIN')
      )
      new_book.save
      authors += item.get_element('ItemAttributes').get_array('Author')
      authors.each do |author|
        Author.create(name:author) unless Author.find_by(name: author).present?
        auth = Author.find_by(name: author)
        cont = Contribution.create(book: new_book, author: auth)
      end
      new_book.save
    end
  end

  scenario 'successfully' do
    visit root_path
    sign_in_as(create(:user))
    visit root_path
    within('.book', text: @books.first.title) do
      click_button 'Add to MyReads'
    end
    click_link 'alex'
    click_link 'ToRead'

    expect(page).to have_content @books.first.title
  end

  scenario 'but already had this book' do
    visit root_path
    sign_in_as(create(:user))
    visit root_path
    within('.book', text: @books.first.title) do
      click_button 'Add to MyReads'
    end
    visit root_path
    within('.book', text: @books.first.title) do
      expect(page).to have_no_button 'Add to MyReads'
    end
  end
end
