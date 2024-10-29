require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe "#Valid?" do
    it "Nome não pode ser vazio" do
      drink = Drink.new(name: "")

      drink.valid?
      result = drink.errors

      expect(result.include?(:name)).to be true
      expect(result[:name]).to include 'não pode ficar em branco'
    end

    it "Descrição não pode ser vazia" do
      drink = Drink.new(description: "")
  
      drink.valid?
      result = drink.errors
  
      expect(result.include?(:description)).to be true
      expect(result[:description]).to include 'não pode ficar em branco'
    end
  
    it "Atributo alcoholic não pode ser vazio" do
      drink = Drink.new(alcoholic: nil)
  
      drink.valid?
      result = drink.errors
  
      expect(result.include?(:alcoholic)).to be true
      expect(result[:alcoholic]).to include 'não pode ficar em branco'
    end
  
    it "Calorias não podem ser vazias" do
      drink = Drink.new(calories: nil)
  
      drink.valid?
      result = drink.errors
  
      expect(result.include?(:calories)).to be true
      expect(result[:calories]).to include 'não pode ficar em branco'
    end
  end
end
