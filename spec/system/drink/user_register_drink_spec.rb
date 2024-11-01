require 'rails_helper'

describe "Usuário cadastra bebidas" do
  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
  
    login_as(user)
    visit drinks_path
    click_on 'Cadastrar Bebida'
    fill_in "Nome",	with: "Caipirinha" 
    fill_in "Descrição",	with: "cachaça e limão" 
    fill_in "Calorias",	with: "180" 
    check "Alcoólico"
    click_on "Enviar"

    expect(page).to have_content 'Bebida cadastrada com sucesso.'
    expect(page).to have_content 'Caipirinha'
    drink = Drink.last
    expect(drink.name).to eq 'Caipirinha'
    expect(drink.alcoholic).to eq true
  end
end