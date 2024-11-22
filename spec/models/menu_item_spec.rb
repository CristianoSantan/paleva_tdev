require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "#valid?" do
    it "menu é obrigatório" do
      menu_item = MenuItem.new(menu: nil)

      menu_item.valid?
      result = menu_item.errors

      expect(result.include?(:menu)).to be true
      expect(result[:menu]).to include 'é obrigatório(a)'
    end

    it "item é obrigatório" do
      menu_item = MenuItem.new(menuable: nil)

      menu_item.valid?
      result = menu_item.errors

      expect(result.include?(:menuable)).to be true
      expect(result[:menuable]).to include 'é obrigatório(a)'
    end
  end
end