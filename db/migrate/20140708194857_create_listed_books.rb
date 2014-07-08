class CreateListedBooks < ActiveRecord::Migration
  def change
    create_table :listed_books do |t|
      t.references :book, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index(:listed_books, [:book_id, :user_id], unique: true)
  end
end
