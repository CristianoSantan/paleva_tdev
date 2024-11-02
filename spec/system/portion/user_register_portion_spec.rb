require 'rails_helper'

describe "Usuário cadastra uma porção" do
  it "em pratos e vê formulario" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'
    click_on 'Cadastrar Porção'

    expect(page).to have_content 'Nova Porção'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Real'
    expect(page).to have_field 'Centavo'
    expect(page).to have_button 'Enviar'
  end

  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'
    click_on 'Cadastrar Porção'
    fill_in "Descrição",	with: "Porção Pequena" 
    fill_in "Real",	with: 20 
    fill_in "Centavo",	with: 0 
    click_on 'Enviar'
    
    expect(current_path).to eq dish_path(1)
    expect(page).to have_content 'Porção cadastrada com sucesso.'
    portion = Portion.last
    expect(portion.description).to eq 'Porção Pequena'
  end
  
end
