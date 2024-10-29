require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "#Valid?" do
    it "deve aceitar o upload de uma imagem" do
      dish = Dish.new()

      dish.image.attach(
        io: File.open('./spec/fixtures/files/test_image.jpg'), 
        filename: 'test_image.jpg', 
        content_type: 'image/jpg'
      )

      expect(dish.image).to be_attached
    end
    
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
