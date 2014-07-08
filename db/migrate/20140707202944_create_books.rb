class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :photo
      t.string :title, index: true
      t.date :published_on
      t.integer :asin, index: true


      t.timestamps
    end
  end
end
