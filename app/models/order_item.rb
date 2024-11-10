class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :orderable, polymorphic: true
  belongs_to :portion
end
