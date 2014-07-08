class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, presence: true

      t.references :book, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
