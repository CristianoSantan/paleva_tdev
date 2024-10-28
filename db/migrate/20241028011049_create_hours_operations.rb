class CreateHoursOperations < ActiveRecord::Migration[7.2]
  def change
    create_table :hours_operations do |t|
      t.references :establishment, null: false, foreign_key: true, default: 0
      t.integer :weekday
      t.time :opening_time
      t.time :closing_time
      t.boolean :closed

      t.timestamps
    end
  end
end
