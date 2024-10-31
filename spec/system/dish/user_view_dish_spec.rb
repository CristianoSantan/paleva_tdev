require 'rails_helper'

describe "Usuário vê tela de pratos" do
  it "e não tem pratos cadastrados" do
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
    click_on 'Pratos'
  
    expect(page).to have_content 'Não existem Pratos cadastrados'
  end

  it "e tem prato cadastrado" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
  
    expect(page).to have_content 'Nome: Toscana'
  end

  it "e vê detalhes" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Toscana'
  
    expect(page).to have_content 'Nome: Toscana'
    expect(page).to have_content 'Descrição: Mussarales, calabresa e cebola'
  end

end