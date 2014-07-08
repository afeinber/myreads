class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search], params[:search_method])
  end
end
