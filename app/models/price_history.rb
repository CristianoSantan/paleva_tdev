class PriceHistory < ApplicationRecord
  belongs_to :portion

  validates :real, :cent, :last_update, presence: true
end
