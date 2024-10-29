require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe "#valid?" do
    it "Nome fantasia não pode ser vazio" do
      establishment = Establishment.new(brand_name: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:brand_name)).to be true
      expect(result[:brand_name]).to include 'não pode ficar em branco'
    end

    it "Nome companhia não pode ser vazio" do
      establishment = Establishment.new(company_name: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:company_name)).to be true
      expect(result[:company_name]).to include 'não pode ficar em branco'
    end

    it "CNPJ não pode ser vazio" do
      establishment = Establishment.new(cnpj: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:cnpj)).to be true
      expect(result[:cnpj]).to include 'não pode ficar em branco'
    end

    it "Endereço não pode ser vazio" do
      establishment = Establishment.new(full_address: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:full_address)).to be true
      expect(result[:full_address]).to include 'não pode ficar em branco'
    end

    it "Telefone não pode ser vazio" do
      establishment = Establishment.new(phone: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:phone)).to be true
      expect(result[:phone]).to include 'não pode ficar em branco'
    end

    it "E-mail não pode ser vazio" do
      establishment = Establishment.new(email: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:email)).to be true
      expect(result[:email]).to include 'não pode ficar em branco'
    end

    it "Código não pode ser vazio" do
      establishment = Establishment.new(code: "")

      establishment.valid?
      result = establishment.errors

      expect(result.include?(:code)).to be true
      expect(result[:code]).to include 'não pode ficar em branco'
    end
    
    it "o cnpj precisa ser um número válido" do
      cnpj = CNPJ.generate
      
      establishment = Establishment.new(cnpj: cnpj)
      
      establishment.valid?
      result = establishment.errors
      expect(result.include?(:cnpj)).to be false
    end

    it "o email precisa ser válido" do
      establishment = Establishment.new(email: 'spock@email')
      
      establishment.valid?
      result = establishment.errors

      expect(result.include?(:email)).to be false
    end

    it "o telefone deve ter de 10 a 11 caracteres" do
      establishment = Establishment.new(phone: '123456789')
  
      establishment.valid?
      result = establishment.errors
      expect(result.include?(:phone)).to be true
      expect(result[:phone]).to include 'é muito curto (mínimo: 10 caracteres)'
    end

    it "o código é unico" do
      cpf = CPF.generate
      cnpj = CNPJ.generate
      user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
      establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )
      
      duplicate_establishment = Establishment.new(code: establishment.code)
      duplicate_establishment.valid?
      result = duplicate_establishment.errors
    
      expect(result.include?(:code)).to be true
      expect(result[:code]).to include 'já está em uso'
    end
  end
end
