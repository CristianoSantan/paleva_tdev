require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "#Valid?" do
    it "Nome é obrigatório" do
      menu = Menu.new(name: "")

      menu.valid?
      result = menu.errors

      expect(result.include?(:name)).to be true
      expect(result[:name]).to include 'não pode ficar em branco'
    end

    it "Nome é único dentro do escopo de estabelecimento" do
      cpf = CPF.generate
      cnpj = CNPJ.generate
      user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
      establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
      menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
      duplicate_menu = Menu.new(name: menu.name, establishment: establishment)

      duplicate_menu.valid?
      result = duplicate_menu.errors

      expect(result.include?(:name)).to be true
      expect(result[:name]).to include 'já existe para este estabelecimento'
    end

    it "Nome não é único fora do escopo de estabelecimento" do
      cpf = CPF.generate
      cnpj = CNPJ.generate
      joao = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
      establishment1 = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: joao )
      andre = User.create!(name: 'Andre', cpf: CPF.generate, email: 'andre@email.com', password: 'password1234')
      establishment2 = Establishment.create!(brand_name: 'spock', company_name: 'spock restaurantes', cnpj: CNPJ.generate,
        full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'spock@email.com', code: 'ABC456', user: andre )
      menu = Menu.create!(name: 'Café da Manhã', establishment: establishment1)
      duplicate_menu = Menu.new(name: menu.name, establishment: establishment2)

      duplicate_menu.valid?
      result = duplicate_menu.errors

      expect(result.include?(:name)).to be false
    end
  end
end