require 'rails_helper'

describe "Usuário vê tela de bebidas" do
  it "e não tem bebidas cadastradas" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
  
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'
  
    expect(page).to have_content 'Não existem bebidas cadastradas'
  end

  it "e tem bebida cadastrada" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    drink = Drink.create!(name: 'Coca-Cola', description: 'Refrigerante', calories: 180, establishment: establishment, alcoholic: true, status: 'enabled')
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'
    
    expect(page).to have_content 'Nome: Coca-Cola'
  end
  
  it "e vê detalhes" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    drink = Drink.create!(name: 'Coca-Cola', description: 'Refrigerante', calories: 180, establishment: establishment, alcoholic: true, status: 'enabled')
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'
    click_on 'Coca-Cola'
  
    expect(page).to have_content 'Nome: Coca-Cola'
    expect(page).to have_content 'Descrição: Refrigerante'
  end
end