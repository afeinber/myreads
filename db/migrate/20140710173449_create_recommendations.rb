class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user, index: true
      t.references :book, index: true

      t.integer :recipient_id, index: true
    end
    add_index(:recommendations, [:recipient_id, :user_id, :book_id], unique: true)
  end
end
