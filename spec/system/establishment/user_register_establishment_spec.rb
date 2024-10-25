require 'rails_helper'

describe "Usuário cadastra seu estabelecimento" do
  it "com todos os campos obrigatorios" do
    cpf = CPF.generate
    # cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    # establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
    #   full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
    #   code: 'ABC123', user: user )

    login_as(user)
    visit new_establishment_path
    
    expect(page).to have_content 'Novo Estabelecimento'
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('Nome companhia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Código')
  end

  it "a partir da tela inicial" do

    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    # establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
    #   full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
    #   code: 'ABC123', user: user )

    login_as(user)
    visit new_establishment_path
    fill_in "Nome fantasia",	with: "pizzafire"
    fill_in "Nome companhia",	with: "pizzafire restaurantes"
    fill_in "CNPJ",	with: cnpj
    fill_in "E-mail",	with: "pizzafire@email.com"
    fill_in "Telefone",	with: "1122332233"
    fill_in "Código",	with: "ABC456"
    click_on 'Criar estabelecimento'

    expect(page).to have_content 'Estabelecimento cadastrado com sucesso.'
    establishment = Establishment.last
    expect(establishment.brand_name).to eq 'pizzafire'
  end
end
