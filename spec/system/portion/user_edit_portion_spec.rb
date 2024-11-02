require 'rails_helper'

describe "Usuário edita uma porção" do
  it "e vê formulario de edição" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'
    click_on 'Editar Porção'

    expect(page).to have_content 'Editar porção Porção Pequena'
    expect(page).to have_field 'Descrição', with: 'Porção Pequena'
    expect(page).to have_field 'Real', with: 20
    expect(page).to have_field 'Centavo', with: 0
    expect(page).to have_button 'Enviar'
  end

  it "e vê formulario de edição" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'
    click_on 'Editar Porção'
    fill_in "Real",	with: 25 
    click_on 'Enviar'
    
    expect(current_path).to eq dish_path(1)
    expect(page).to have_content 'Porção editada com sucesso.'
    expect(page).to have_content 'R$ 25,00'
  end
end