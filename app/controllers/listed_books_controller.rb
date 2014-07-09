class ListedBooksController < ApplicationController
  def create

    @book = Book.from_amazon_element(
      Amazon::Ecs.item_lookup(params[:asin],
      {:response_group => 'Medium'}).items.first
    ) unless (@book = Book.find_by(asin: params[:asin])).present?

    @listed_book = ListedBook.new
    @listed_book.user = current_user
    @listed_book.book = @book

    @listed_book.save

    redirect_to :back
  end


  private

  def listed_book_params
  end
end
