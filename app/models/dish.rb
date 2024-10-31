class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  enum :status, { :enabled => true, :disabled => false}

  validates :name, :description, :calories, presence: true
end
