require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "#valid?" do
    it "pedido é obrigatório" do
      order_item = OrderItem.new(order: nil)

      order_item.valid?
      result = order_item.errors

      expect(result.include?(:order)).to be true
      expect(result[:order]).to include 'é obrigatório(a)'
    end
    
    it "item é obrigatório" do
      order_item = OrderItem.new(orderable: nil)

      order_item.valid?
      result = order_item.errors

      expect(result.include?(:orderable)).to be true
      expect(result[:orderable]).to include 'é obrigatório(a)'
    end

    it "porção é obrigatório" do
      order_item = OrderItem.new(portion: nil)

      order_item.valid?
      result = order_item.errors

      expect(result.include?(:portion)).to be true
      expect(result[:portion]).to include 'é obrigatório(a)'
    end
  end
end