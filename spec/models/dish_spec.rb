require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "#Valid?" do
    it "Nome não pode ser vazio" do
      dish = Dish.new(name: "")

      dish.valid?
      result = dish.errors

      expect(result.include?(:name)).to be true
      expect(result[:name]).to include 'não pode ficar em branco'
    end

    it "Descrição não pode ser vazia" do
      dish = Dish.new(description: "")

      dish.valid?
      result = dish.errors

      expect(result.include?(:description)).to be true
      expect(result[:description]).to include 'não pode ficar em branco'
    end

    it "Calorias não pode ser vazia" do
      dish = Dish.new(calories: nil)

      dish.valid?
      result = dish.errors

      expect(result.include?(:calories)).to be true
      expect(result[:calories]).to include 'não pode ficar em branco'
    end
  end
end
