class CreateEstablishments < ActiveRecord::Migration[7.2]
  def change
    create_table :establishments do |t|
      t.string :brand_name
      t.string :company_name
      t.string :cnpj
      t.string :full_address
      t.string :phone
      t.string :email
      t.string :code
      t.references :user, null: false, foreign_key: true, default: 0

      t.timestamps
    end
  end
end
