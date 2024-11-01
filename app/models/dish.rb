class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  enum :status, { :enabled => 0, :disabled => 5}

  validates :name, :description, :calories, presence: true
end
