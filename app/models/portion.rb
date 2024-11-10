class Portion < ApplicationRecord
  belongs_to :portionable, polymorphic: true
  has_many :price_histories
  has_many :order_items

  def full_description
    "#{description}: R$ #{real},#{cent.to_s.rjust(2, '0')}"
  end
end
