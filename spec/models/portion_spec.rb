require 'rails_helper'

RSpec.describe Portion, type: :model do
  describe "#valid?" do
    it "prato ou bebida é obrigatório" do
      portion = Portion.new(portionable: nil)

      portion.valid?
      result = portion.errors

      expect(result.include?(:portionable)).to be true
      expect(result[:portionable]).to include 'é obrigatório(a)'
    end

    it "real não pode ficar em branco" do
      portion = Portion.new(real: nil)

      portion.valid?
      result = portion.errors

      expect(result.include?(:real)).to be true
      expect(result[:real]).to include 'não pode ficar em branco'
    end

    it "centavo não pode ficar em branco" do
      portion = Portion.new(cent: nil)

      portion.valid?
      result = portion.errors

      expect(result.include?(:cent)).to be true
      expect(result[:cent]).to include 'não pode ficar em branco'
    end

    it "descrição não pode ficar em branco" do
      portion = Portion.new(description: nil)

      portion.valid?
      result = portion.errors

      expect(result.include?(:description)).to be true
      expect(result[:description]).to include 'não pode ficar em branco'
    end
  end
end