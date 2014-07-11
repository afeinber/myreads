class AddIsReadToListedBooks < ActiveRecord::Migration
  def change
    add_column :listed_books, :is_read, :boolean
  end
end
