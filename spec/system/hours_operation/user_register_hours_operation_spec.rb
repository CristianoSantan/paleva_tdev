require 'rails_helper'

describe "Usuário registra um horário" do
  it "e vê tela de cadastro" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Cadastrar Horário'

    expect(page).to have_content 'Novo Horário'
    expect(page).to have_field 'Dia da Semana'
    expect(page).to have_field 'Abertura'
    expect(page).to have_field 'Fechamento'
    expect(page).to have_field 'Fechado'
    expect(page).to have_button 'Enviar'
  end
  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Cadastrar Horário'
    select 'segunda-feira',	from: "Dia da Semana" 
    fill_in "Abertura",	with: "18:00" 
    fill_in "Fechamento",	with: "22:00" 
    check 'Fechado'
    click_on 'Enviar'

    expect(page).to have_content 'Horário cadastrado com sucesso.'
  end
  it "com dados incompletos" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Cadastrar Horário'
    # select '',	from: "Dia da Semana" 
    fill_in "Abertura",	with: "" 
    fill_in "Fechamento",	with: "" 
    click_on 'Enviar'

    expect(page).to have_content 'Horário não cadastrado.'
  end
end
