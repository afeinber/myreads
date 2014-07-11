class ListedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :book, :user, presence: true
  validates :order_index, uniqueness: { scope: [:user, :is_read] }
  validates :book_id, uniqueness: { scope: :user }

  before_save :delete_recommendations

  def insert_or_remove_book(inserting: inserting)
    self.user.listed_books.where(is_read: self.is_read).each_with_index do |book, i|
      self.user.listed_books[i].order_index += 1 if book.order_index >= self.order_index && inserting
      self.user.listed_books[i].order_index -= 1 if book.order_index >= self.order_index && !inserting
    end
    self.user.listed_books.where(is_read: self.is_read).each(&:save)
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
