class ListedBooksController < ApplicationController

  def create
    @book = Book.get_book(params[:asin])
    @listed_book = ListedBook.new
    @listed_book.user = current_user
    @listed_book.book = @book
    @listed_book.order_index = 0

    @listed_book.reorder_books
    if @listed_book.save
      flash[:notice] = "#{@listed_book.book.title} added to your MyReads."
    else
      flash[:alert] = 'Error: ' + @listed_book.errors.full_messages.join(', ')
    end

    redirect_to :back
  end



end
