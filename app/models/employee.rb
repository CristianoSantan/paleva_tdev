class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :establishment

  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
end
