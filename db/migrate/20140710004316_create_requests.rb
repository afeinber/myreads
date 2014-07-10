class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, index: true
      t.integer :recipient_id
    end
    add_index(:requests, [:recipient_id, :user_id], unique: true)
  end
end
