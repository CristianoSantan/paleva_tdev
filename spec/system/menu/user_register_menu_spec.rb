require 'rails_helper'

describe "Usuário cadastra um menu" do
  it "e vê formulario" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

    login_as(user)
    visit menus_path
    click_on 'Cadastrar Cardápio'

    expect(current_path).to eq new_menu_path
    expect(page).to have_content 'Novo Cardápio'
    expect(page).to have_field 'Nome do Cardápio'
    expect(page).to have_button 'Enviar'
  end

  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

    login_as(user)
    visit menus_path
    click_on 'Cadastrar Cardápio'
    fill_in "Nome do Cardápio",	with: "Café da Manhã" 
    click_on 'Enviar'

    expect(current_path).to eq menu_path(1)
    expect(page).to have_content 'Cardápio cadastrado com sucesso'
    menu = Menu.last
    expect(menu.name).to eq 'Café da Manhã'
    expect(page).to have_content 'Cardápio: Café da Manhã'
  end

  it "com campo vazio" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

    login_as(user)
    visit menus_path
    click_on 'Cadastrar Cardápio'
    fill_in "Nome do Cardápio",	with: "" 
    click_on 'Enviar'

    expect(page).to have_content 'Cardápio não cadastrado'
    expect(page).to have_content 'Novo Cardápio'
    expect(page).to have_field 'Nome do Cardápio'
  end
end