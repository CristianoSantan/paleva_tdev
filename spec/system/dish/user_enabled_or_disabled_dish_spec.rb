require 'rails_helper'

describe "Usuário ativa ou desativa o prato" do
  it "e vê o botão de desativar na página de detalhes" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment, status: 'enabled')
    
    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Toscana'

    expect(page).to have_button 'Desativar'
  end

  it "e desativa na página de detalhes" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment, status: 'enabled')
    
    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Toscana'
    click_on 'Desativar'

    expect(page).to have_content 'Situação do Prato: Desativado(a)'
  end

  it "e ativa na página de detalhes" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment, status: 'disabled')
    
    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Toscana'
    click_on 'Ativar'

    expect(page).to have_content 'Situação do Prato: Ativado(a)'
  end

  it "e vê a informação na lista" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Toscana', description: 'Mussarales, calabresa e cebola', calories: 300, establishment: establishment, status: 'disabled')
    
    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'

    within("#dish_1") do
      expect(page).to have_content 'Situação do Prato: Desativado(a)'
    end
  end
end
