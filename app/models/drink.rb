class Drink < ApplicationRecord
  belongs_to :establishment

  has_one_attached :image

  validates :name, :description, :alcoholic, presence: true
end
