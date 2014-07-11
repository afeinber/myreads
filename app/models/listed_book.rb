class ListedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates! :book, :user, presence: true
  validates! :order_index, uniqueness: { scope: [:user, :is_read] }
  validates! :book_id, uniqueness: { scope: :user }

  before_save :delete_recommendations

  # def insert_or_remove_book(inserting: inserting, index: index)

  #   relevant_books = self.user.listed_books.where(is_read: self.is_read)
  #   relevant_books.each_with_index do |book, i|
  #     relevant_books[i].order_index += 1 if book.order_index >= index && inserting
  #     relevant_books[i].order_index -= 1 if book.order_index > index && !inserting
  #   end
  #   binding.pry
  #   relevant_books.each(&:save)
  # end



  def move_book(position)

    relevant_books = self.user.listed_books.where(is_read: self.is_read).order(:order_index)
    from = self.order_index
    difference = position - from
    if difference > 0
      relevant_books = relevant_books[from+1, position]
      relevant_books.each_with_index { |book, i| relevant_books[i].order_index -= 1}
    else
      relevant_books = relevant_books[position, from -1]
      relevant_books.each_with_index { |book, i| relevant_books[i].order_index += 1}
    end
    self.order_index = position
    relevant_books.each(&:save)
    self.save
  end

  def insert_book(position, is_read)
    relevant_books = self.user.listed_books.where(is_read: is_read).where('order_index >= ?', position)
    relevant_books.each_with_index { |book, i| relevant_books[i].order_index += 1}
    relevant_books.each(&:save)
  end

  def remove_book
    relevant_books = self.user.listed_books.where(is_read: self.is_read).order(:order_index)
    self.move_book(relevant_books.count - 1)
  end
  # def remove_book
  #   self.user.listed_books.where(is_read: self.is_read).each_with_index do |book, i|
  #     self.user.listed_books[i].order_index += 1 if book.order_index >= self.order_index
  #   end
  #   self.user.listed_books.each { |book| book.save }
  # end

  def delete_recommendations
    self.user.inverse_recommendations.where(book: self.book).each(&:destroy)
  end

end
