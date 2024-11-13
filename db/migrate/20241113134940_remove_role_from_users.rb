class RemoveRoleFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :role, :integer
  end
end
