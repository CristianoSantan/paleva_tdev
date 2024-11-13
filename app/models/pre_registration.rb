class PreRegistration < ApplicationRecord
  belongs_to :establishment

  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
end
