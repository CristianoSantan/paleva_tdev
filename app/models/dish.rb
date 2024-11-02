class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  has_many :portions, as: :portionable
  enum :status, { :enabled => 0, :disabled => 5}

  validates :name, :description, :calories, presence: true
end
