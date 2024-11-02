class CreatePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :portions do |t|
      t.references :portionable, polymorphic: true, null: false
      t.string :description
      t.integer :real
      t.integer :cent

      t.timestamps
    end
  end
end
