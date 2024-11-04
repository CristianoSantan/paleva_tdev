require 'rails_helper'

describe "Usuário vê historico de preços" do
  it "na página do prato" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)
    portion_2 = Portion.create!(description: 'Porção Grande', real: 35, cent: 0, portionable: dish)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'

    expect(page).to have_content 'Histórico de Preços'
  end

  it "e vê os preços antigos" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)
    price_history = PriceHistory.create!(portion:portion_1, real:portion_1.real, cent:portion_1.cent, last_update: DateTime.now)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'

    expect(page).to have_content 'Histórico de Preços'
    within '#price-histories' do
      expect(page).to have_content "Porção Pequena 20,00 #{ price_history.last_update }"
    end
  end
end