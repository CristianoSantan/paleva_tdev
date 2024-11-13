class PreRegistration < ApplicationRecord
  belongs_to :establishment

  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :cpf, length: { is: 11 }
  validate :cpf_valid

  private

  def cpf_valid
    unless CPF.valid?(self.cpf)
      self.errors.add(:cpf, "deve ser válido")
    end
  end
end
