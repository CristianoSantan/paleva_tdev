class Tag < ApplicationRecord
  belongs_to :establishment
  has_many :dish_tags
  has_many :dishes, through: :dish_tags

end
