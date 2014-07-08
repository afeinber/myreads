require 'rails_helper'

feature 'User views the books' do

  background do

  end


  scenario 'and sees the top 10 books' do
    books = []
    res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium'})
    res.items.each do |item|
      authors = []
      books << new_book = Book.create!(
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
    visit root_path
    save_and_open_page

    books.each do |book|

      within('.book', text: book.title) do
        expect(page).to have_content book.authors.first.name
      end
    end
  end
end
