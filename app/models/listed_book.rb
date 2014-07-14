class ListedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates! :book, :user, presence: true
  validates! :order_index, uniqueness: { scope: [:user, :is_read] }
  validates! :book_id, uniqueness: { scope: :user }

  before_save :delete_recommendations


  #This moves the index of a listed book, to set the priority.
  def move_book(position)
    reset_indices

    ListedBook.transaction do
      relevant_books = self.user.listed_books.where(is_read: self.is_read).order(:order_index)
      max = relevant_books.map(&:order_index).max
      from = self.order_index
      difference = position - from
      if difference > 0
        relevant_books = relevant_books[from+1..position]
        relevant_books.each_with_index { |book, i| relevant_books[i].order_index -= 1 }
      elsif difference < 0
        relevant_books = relevant_books[position..from -1]
        relevant_books.each_with_index { |book, i| relevant_books[i].order_index += 1 }
      end
      self.order_index = max + 2
      self.save
      relevant_books.each(&:save)
      self.order_index = position
      self.save
    end
  end

  def insert_book(position, is_read)
    reset_indices
    relevant_books = self.user.listed_books.where(is_read: is_read).where('order_index >= ?', position).order(:order_index).reverse
    relevant_books.each_with_index do |book, i|
      relevant_books[i].order_index += 1
      relevant_books[i].save
    end
  end

  def remove_book
    reset_indices
    relevant_books = self.user.listed_books.where(is_read: self.is_read).order(:order_index)
    self.move_book(relevant_books.count - 1)
  end


  def delete_recommendations
    self.user.inverse_recommendations.where(book: self.book).each(&:destroy)
  end

  #Keeps everything tidy by starting priorities at 0 and sequentializing them
  def reset_indices
    relevant_books = self.user.listed_books.where(is_read: true).order(:order_index)
    relevant_books.each_with_index { |book, i| relevant_books[i].order_index = i }
    relevant_books.each(&:save)
    relevant_books = self.user.listed_books.where(is_read: false).order(:order_index)
    relevant_books.each_with_index { |book, i| relevant_books[i].order_index = i }
    relevant_books.each(&:save)

  end

end
