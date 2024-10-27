class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :establishment

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: { is: 11 }
  validate :cpf_valid

  private

  def cpf_valid
    unless CPF.valid?(self.cpf)
      self.errors.add(:cpf, "deve ser válido")
    end
  end
end
