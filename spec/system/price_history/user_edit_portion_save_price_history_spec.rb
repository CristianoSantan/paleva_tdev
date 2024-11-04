require 'rails_helper'

describe "Usuário edita porção e salva o preço" do
  it "em pratos" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    # portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)

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
    click_on 'Editar Porção'
    fill_in "Real",	with: 25 
    click_on 'Enviar'
    
    expect(current_path).to eq dish_path(1)
    expect(page).to have_content 'Porção editada com sucesso.'
    expect(page).to have_content 'R$ 25,00'
    within '#price-histories' do
    expect(page).to have_content "Porção Pequena 20,00"
    expect(page).to have_content "Porção Pequena 25,00"
  end
  end
  
end
