class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :image
  has_many :portions, as: :portionable
  has_many :dish_tags, dependent: :destroy
  has_many :tags, through: :dish_tags
  accepts_nested_attributes_for :tags, allow_destroy: true
  
  enum :status, { :enabled => 0, :disabled => 5 }

  validates :name, :description, :calories, presence: true
end
