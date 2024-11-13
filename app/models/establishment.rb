class Establishment < ApplicationRecord
  belongs_to :user
  
  has_many :dishes
  has_many :drinks
  has_many :hours_operations
  has_many :tags
  has_many :menus
  has_many :orders
  has_many :employees
  has_many :pre_registrations

  validates :brand_name, :company_name, :cnpj, :full_address, :phone, :email, :code, presence: true
  validates :phone, length: { minimum:10, maximum:11 }
  validates :code, uniqueness: true
  validate :cnpj_valid

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase if self.code.nil?
  end

  def cnpj_valid
    unless CNPJ.valid?(self.cnpj)
      self.errors.add(:cnpj, "deve ser válido")
    end
  end
end
