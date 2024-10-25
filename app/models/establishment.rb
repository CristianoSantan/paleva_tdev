class Establishment < ApplicationRecord
  belongs_to :user

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
