class CreatePreRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :pre_registrations do |t|
      t.string :email
      t.string :cpf
      t.boolean :used, default: false
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
