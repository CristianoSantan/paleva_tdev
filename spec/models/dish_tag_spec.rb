require 'rails_helper'

RSpec.describe DishTag, type: :model do
  describe "#valid?" do
    it "prato é obrigatório" do
      dish_tag = DishTag.new(dish: nil)

      dish_tag.valid?
      result = dish_tag.errors

      expect(result.include?(:dish)).to be true
      expect(result[:dish]).to include 'é obrigatório(a)'
    end
    
    it "tag é obrigatório" do
      dish_tag = DishTag.new(tag: nil)

      dish_tag.valid?
      result = dish_tag.errors

      expect(result.include?(:tag)).to be true
      expect(result[:tag]).to include 'é obrigatório(a)'
    end
  end
end