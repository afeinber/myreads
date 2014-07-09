class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search], params[:search_method])
  end

  def show
    @book = Book.get_book(params[:asin])
  end
end
