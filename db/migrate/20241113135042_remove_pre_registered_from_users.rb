class RemovePreRegisteredFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :pre_registered, :boolean
  end
end
