require 'rails_helper'

feature 'user views reading list' do
  scenario 'and sees all his/her books' do
    user_a = User.create(username: 'alex', email: 'a@example.com', password: 'password')
    user_b = User.create(username: 'b', email: 'b@example.com', password: 'password')
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

    user_a.books << @books.first
    user_b.books << @books[1]

    visit root_path

    sign_in_as(user_a)

    click_link 'alex'
    click_link 'ToRead'

    expect(page).to have_content @books.first.title
    expect(page).to have_no_content @books[1].title


  end
end
