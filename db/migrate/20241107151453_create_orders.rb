class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :cpf
      t.string :code
      t.integer :status
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
