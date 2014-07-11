class AddDefaultToIsReadOnListedBooks < ActiveRecord::Migration
  def up
    change_column :listed_books, :is_read, :boolean, :null => false, :default => false
  end

  def down
    change_column :listed_books, :is_read, :boolean, :null => true, :default => nil
  end
end
