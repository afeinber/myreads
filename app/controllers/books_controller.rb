class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search], params[:search_method], current_user)
    unless @books.present?
      #@books = Book.top_sellers
      flash[:notice] = "Amazon's Best Sellers. Please follow more users to see individulaized results."
    end

  end

  def show
    @book = Book.get_book(params[:asin])
    @comment = Comment.new
  end
end
