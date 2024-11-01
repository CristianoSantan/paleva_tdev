require 'rails_helper'

describe "Usuário ativa ou desativa o bebida" do
  it "e vê o botão de desativar na página de detalhes" do
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

    expect(page).to have_content 'Situação da Bebida: Ativado(a)'
    expect(page).to have_button 'Desativar'
  end

  it "e desativa na página de detalhes" do
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
    click_on 'Desativar'

    expect(page).to have_content 'Situação da Bebida: Desativado(a)'
  end

  it "e ativa na página de detalhes" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    drink = Drink.create!(name: 'Coca-Cola', description: 'Refrigerante', calories: 180, establishment: establishment, alcoholic: true, status: 'disabled')
  
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'
    click_on 'Coca-Cola'
    click_on 'Ativar'

    expect(page).to have_content 'Situação da Bebida: Ativado(a)'
  end

  it "e vê a informação na lista" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    drink = Drink.create!(name: 'Coca-Cola', description: 'Refrigerante', calories: 180, establishment: establishment, alcoholic: true, status: 'disabled')
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'

    within("#drink_1") do
      expect(page).to have_content 'Situação da Bebida: Desativado(a)'
    end
  end
end
