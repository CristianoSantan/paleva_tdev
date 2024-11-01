class RemoveStatusFromDish < ActiveRecord::Migration[7.2]
  def change
    remove_column :dishes, :status, :integer
  end
end
