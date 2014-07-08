class CreateContribution < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.references :author, index: true
      t.references :book, index: true


    end
  end
end
