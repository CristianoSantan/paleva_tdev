require 'rails_helper'

describe "Usuário cadastra seu estabelecimento" do
  it "com todos os campos obrigatorios" do
    cpf = CPF.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')

    login_as(user)
    visit new_establishment_path
    
    expect(page).to have_content 'Novo Estabelecimento'
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('Nome companhia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('E-mail')
  end

  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')

    login_as(user)
    visit new_establishment_path
    fill_in "Nome fantasia",	with: "pizzafire"
    fill_in "Nome companhia",	with: "pizzafire restaurantes"
    fill_in "CNPJ",	with: cnpj
    fill_in "E-mail",	with: "pizzafire@email.com"
    fill_in "Endereço",	with: "Rua Ana Maria, 1050"
    fill_in "Telefone",	with: "1122332233"
    click_on 'Enviar'

    expect(page).to have_content 'Estabelecimento cadastrado com sucesso.'
    establishment = Establishment.last
    expect(establishment.brand_name).to eq 'pizzafire'
  end

  it "com dados incompletos" do
    cpf = CPF.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')

    login_as(user)
    visit new_establishment_path
    fill_in "Nome fantasia",	with: ""
    fill_in "Nome companhia",	with: ""
    fill_in "CNPJ",	with: ""
    fill_in "E-mail",	with: ""
    fill_in "Endereço",	with: ""
    fill_in "Telefone",	with: ""
    click_on 'Enviar'

    expect(page).to have_content 'Estabelecimento não cadastrado.'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Nome companhia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Telefone é muito curto (mínimo: 10 caracteres)'
  end
end
