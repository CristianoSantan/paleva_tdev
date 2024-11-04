class Portion < ApplicationRecord
  belongs_to :portionable, polymorphic: true
  has_many :price_histories
end
