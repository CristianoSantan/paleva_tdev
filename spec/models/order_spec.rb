require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "nome não pode ficar vazio" do
      order = Order.new(name: "")

      order.valid?
      result = order.errors

      expect(result.include?(:name)).to be true
      expect(result[:name]).to include 'não pode ficar em branco'
    end

    it "telefone e email não podem ficar vazios" do
      order = Order.new(phone: "", email: "")

      order.valid?
      result = order.errors

      expect(result.include?(:phone)).to be true
      expect(result[:phone]).to include 'não pode ficar em branco'
      expect(result.include?(:phone)).to be true
      expect(result[:phone]).to include 'não pode ficar em branco'
    end

    it "email pode ficar vazio se for passado um telefone" do
      order = Order.new(phone: "11977887788", email: "")

      order.valid?
      result = order.errors

      expect(result.include?(:email)).to be false
    end

    it "telefone pode ficar vazio se for passado um email" do
      order = Order.new(phone: "", email: "andre@email.com")

      order.valid?
      result = order.errors

      expect(result.include?(:phone)).to be false
    end

    it "cpf não pode ficar vazio" do
      order = Order.new(cpf: "")

      order.valid?
      result = order.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'não pode ficar em branco'
    end

    it "cpf não possui o tamanho esperado" do
      order = Order.new(cpf: '123654')
    
      order.valid?
      result = order.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'não possui o tamanho esperado (11 caracteres)'
    end

    it "cpf com número inválido" do
      order = Order.new(cpf: '35612345610')
    
      order.valid?
      result = order.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'deve ser válido'
    end
    
    it "cpf com número válido" do
      order = Order.new(cpf: CPF.generate)
      
      order.valid?
      result = order.errors
      expect(result.include?(:cpf)).to be false
    end

    it "estabelecimento é obrigatório" do
      order = Order.new(establishment: nil)

      order.valid?
      result = order.errors

      expect(result.include?(:establishment)).to be true
      expect(result[:establishment]).to include 'é obrigatório(a)'
    end
  end
end