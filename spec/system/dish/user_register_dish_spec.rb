require 'rails_helper'

describe "Usuário cadastra pratos" do
  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
  
    login_as(user)
    visit dishes_path
    click_on 'Cadastrar Prato'
    fill_in "Nome",	with: "Frango" 
    fill_in "Descrição",	with: "assado" 
    fill_in "Calorias",	with: "250" 
    click_on "Enviar"

    expect(page).to have_content 'Prato cadastrado com sucesso.'
    expect(page).to have_content 'tranbolho'
    dish = Dish.last
    expect(dish.name).to eq 'Frango'
  end
end