class AddStatusToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :status, :integer, default: 0
  end
end
