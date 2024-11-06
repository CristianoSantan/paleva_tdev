class Menu < ApplicationRecord
  belongs_to :establishment

  validates :name, presence: true
  
end
