class ChangeAsinFormatInBooks < ActiveRecord::Migration
  def up
    change_column :books, :asin, :string
  end

  def down
    change_column :books, :asin, 'integer USING CAST(asin AS integer)'
  end

end
