class CreateMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menus do |t|
      t.string :name
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
