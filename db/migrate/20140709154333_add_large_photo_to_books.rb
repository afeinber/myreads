class AddLargePhotoToBooks < ActiveRecord::Migration
  def change
    add_column :books, :large_photo, :string
  end
end
