class AddOrderIndexToListedBooks < ActiveRecord::Migration
  def change
    add_column :listed_books, :order_index, :integer
  end
end
