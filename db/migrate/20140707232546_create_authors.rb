class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
    end

    add_index :authors, :name, :unique => true
  end
end
