class ListedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :book, :user, presence: true
  validates :order_index, uniqueness: { scope: :user }
  validates :book_id, uniqueness: { scope: :user }

  before_save :delete_recommendations

  def reorder_books
    self.user.listed_books.each_with_index do |book, i|
      self.user.listed_books[i].order_index += 1 if book.order_index >= self.order_index
    end
    self.user.listed_books.each { |book| book.save }
  end

  def delete_recommendations
    self.user.inverse_recommendations.where(book: self.book).each { |rec| rec.destroy }
  end

end
