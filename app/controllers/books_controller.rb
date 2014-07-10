class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search], params[:search_method], current_user)

  end

  def show
    @book = Book.get_book(params[:asin])
    @comment = Comment.new
  end
end
