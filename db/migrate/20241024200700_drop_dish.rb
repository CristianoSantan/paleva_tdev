class DropDish < ActiveRecord::Migration[7.2]
  def change
    drop_table :dishes
  end
end
