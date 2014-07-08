class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search])
  end
end
