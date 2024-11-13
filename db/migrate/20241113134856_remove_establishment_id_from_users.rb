class RemoveEstablishmentIdFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :establishment_id, :integer
  end
end
