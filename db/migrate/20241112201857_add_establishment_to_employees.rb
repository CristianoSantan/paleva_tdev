class AddEstablishmentToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_reference :employees, :establishment, null: false, foreign_key: true
  end
end
