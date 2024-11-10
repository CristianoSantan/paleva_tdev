class Drink < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  has_many :portions, as: :portionable
  has_many :menu_items, as: :menuable
  has_many :menus, through: :menu_items
  has_many :order_items, as: :orderable
  has_many :orders, through: :order_items
  
  enum :status, { :enabled => 0, :disabled => 5 }

  validates :name, :description, :calories, presence: true
  validates :alcoholic, inclusion: { in: [true, false], message: "deve ser verdadeiro ou falso" }
end
