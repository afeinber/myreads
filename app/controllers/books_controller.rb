class BooksController < ApplicationController

  def index
    @books = Book.top_ten
  end
end
