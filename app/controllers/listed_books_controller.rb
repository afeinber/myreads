class ListedBooksController < ApplicationController



  def create
    @book = Book.get_book(params[:asin])
    @listed_book = ListedBook.new
    @listed_book.user = current_user
    @listed_book.book = @book
    @listed_book.order_index = 0
    @listed_book.insert_book(0, false)
    if @listed_book.save
      flash[:notice] = "#{@listed_book.book.title} added to your MyReads."
    else
      flash[:alert] = 'Error: ' + @listed_book.errors.full_messages.join(', ')
    end

    redirect_to :back
  end

  def update

    @listed_book = ListedBook.find(params[:id])

    if params[:is_read].present?
      @listed_book.remove_book
      @listed_book.insert_book(0, params[:is_read])
      @listed_book.is_read = params[:is_read]
      @listed_book.order_index = 0
      @listed_book.save
    elsif params[:move] == "up"
      @listed_book.move_book(@listed_book.order_index - 1)
    elsif params[:move] == "down"
      @listed_book.move_book(@listed_book.order_index + 1)
    end
    redirect_to :back
  end
end
