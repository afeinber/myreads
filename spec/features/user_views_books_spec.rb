require 'rails_helper'

feature 'User views the books' do

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

    alex = User.new(username:'Alex', email: 'alex@example.com', password: 'password')
    a_book = Book.first
    Comment.create(user: alex, book: a_book, content: 'Old content')
    @com2 = Comment.create(user: alex, book: a_book, content: 'New content')
    visit root_path
  end



  scenario 'and sees the top 10 books' do

    @books.each do |book|

      within('.book', text: book.title) do
        expect(page).to have_content book.authors.first.name
      end
    end
  end
  scenario 'and the most recent comment' do
    within('.book', text: @books.first.title) do
      expect(page).to have_content @com2.content
    end
  end
end

