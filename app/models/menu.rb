class Menu < ApplicationRecord
  belongs_to :establishment
  has_many :menu_items
  has_many :dishes, through: :menu_items, source: :menuable, source_type: 'Dish'
  has_many :drinks, through: :menu_items, source: :menuable, source_type: 'Drink'

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :establishment_id, message: "já existe para este estabelecimento" }
end
