require 'rails_helper'

RSpec.describe PreRegistration, type: :model do
  describe "#valid?" do
    it "email não pode ser vazio" do
      pre_registration = PreRegistration.new(email: "")

      pre_registration.valid?
      result = pre_registration.errors

      expect(result.include?(:email)).to be true
      expect(result[:email]).to include 'não pode ficar em branco'
    end

    it "cpf não pode ser vazio" do
      pre_registration = PreRegistration.new(cpf: "")

      pre_registration.valid?
      result = pre_registration.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'não pode ficar em branco'
    end

    it "cpf com número inválido" do
      pre_registration = PreRegistration.new(cpf: "35612345610")

      pre_registration.valid?
      result = pre_registration.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'deve ser válido'
    end

    it "cpf com número válido" do
      pre_registration = PreRegistration.new(cpf: CPF.generate)

      pre_registration.valid?
      result = pre_registration.errors

      expect(result.include?(:cpf)).to be false
    end

    it "cpf é único" do
      user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
      establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
        user: user )
      cpf = CPF.generate
      first = PreRegistration.create!(cpf: cpf, email: 'andre@email.com', establishment: establishment)
      second = PreRegistration.new(cpf: cpf, email: 'maria@email.com', establishment: establishment)
      
      second.valid?
      result = second.errors
      
      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'já está em uso'
    end
    
    it "estabelecimento é obrigatório" do
      pre_registration = PreRegistration.new(establishment: nil)

      pre_registration.valid?
      result = pre_registration.errors

      expect(result.include?(:establishment)).to be true
      expect(result[:establishment]).to include 'é obrigatório(a)'
    end
    
    it "pre cadastro não foi usado" do
      user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
      establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
        user: user )
      pre_registration = PreRegistration.create!(cpf: CPF.generate, email: 'andre@email.com', establishment: establishment)

      expect(pre_registration.used).to eq false
    end
  end
end