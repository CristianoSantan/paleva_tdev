class Order < ApplicationRecord
  belongs_to :establishment
  has_many :order_items, dependent: :destroy
  has_many :drinks, through: :order_items
  has_many :dishes, through: :order_items

  accepts_nested_attributes_for :order_items, allow_destroy: true

  enum :status, { 'waiting' => 0, 'in_preparation' => 5, 'canceled' => 10, 'ready' => 15, 'delivered' => 20 }
  
  before_validation :generate_code, on: :create

  def total
    real = order_items.includes(:portion).sum { |item| item.portion.real }
    cent = order_items.includes(:portion).sum { |item| item.portion.cent }
    total = real.to_f + cent.to_f / 100
    "#{total}"
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
