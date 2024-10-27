class Establishment < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :drinks

  validates :brand_name, :company_name, :cnpj, :full_address, :phone, :email, :code, presence: true
  validates :phone, length: {minimum:10, maximum:11}

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
