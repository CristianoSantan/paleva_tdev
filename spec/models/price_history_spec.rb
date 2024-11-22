require 'rails_helper'

RSpec.describe PriceHistory, type: :model do
  describe "#valid?" do
    it "porção é obrigatório" do
      price_historie = PriceHistory.new(portion: nil)

      price_historie.valid?
      result = price_historie.errors

      expect(result.include?(:portion)).to be true
      expect(result[:portion]).to include 'é obrigatório(a)'
    end

    it "real não pode ficar em branco" do
      price_historie = PriceHistory.new(real: nil)

      price_historie.valid?
      result = price_historie.errors

      expect(result.include?(:real)).to be true
      expect(result[:real]).to include 'não pode ficar em branco'
    end

    it "centavo não pode ficar em branco" do
      price_historie = PriceHistory.new(cent: nil)

      price_historie.valid?
      result = price_historie.errors

      expect(result.include?(:cent)).to be true
      expect(result[:cent]).to include 'não pode ficar em branco'
    end
    
    it "ultima atualização não pode ficar em branco" do
      price_historie = PriceHistory.new(last_update: nil)

      price_historie.valid?
      result = price_historie.errors

      expect(result.include?(:last_update)).to be true
      expect(result[:last_update]).to include 'não pode ficar em branco'
    end
  end
end