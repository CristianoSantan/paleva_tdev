class AddStatusToDrink < ActiveRecord::Migration[7.2]
  def change
    add_column :drinks, :status, :integer, default: 0
  end
end
