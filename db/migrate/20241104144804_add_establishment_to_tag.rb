class AddEstablishmentToTag < ActiveRecord::Migration[7.2]
  def change
    add_reference :tags, :establishment, null: false, foreign_key: true, default: 0
  end
end
