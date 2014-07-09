class ListedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user



  validates :book, :user, presence: true
  validates :order_index, uniqueness: {scope: :user}



  def reorder_books

    self.user.listed_books.each_with_index do |book, i|
      self.user.listed_books[i].order_index += 1 if book.order_index >= self.order_index
    end
    self.user.listed_books.each { |book| book.save }
  end


end
