require 'rails_helper'

describe "Usuário edita um estabelecimento" do
  it "a partir da página inicial" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user, scope: :user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Editar'

    expect(page).to have_content "Editar Estabelecimento: #{establishment.code}"
    expect(page).to have_field('Nome fantasia', with: 'pizzafire')
    expect(page).to have_field('Nome companhia', with: 'pizzafire restaurantes')
    expect(page).to have_field('CNPJ', with: cnpj)
    expect(page).to have_field('Endereço', with: 'Rua Dom Pedro, 280')
    expect(page).to have_field('Telefone', with: '1122332233')
    expect(page).to have_field('E-mail', with: 'pizzafire@email.com')
  end

  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user, scope: :user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'Spock'
    fill_in 'Nome companhia', with: 'Spock Restaurantes'
    fill_in 'CNPJ', with: cnpj
    fill_in 'Endereço', with: 'Rua Ana Maria, 1050'
    fill_in 'Telefone', with: '1199889988'
    fill_in 'E-mail', with: 'spock@email.com'
    click_on 'Enviar'

    expect(page).to have_content 'Estabelecimento atualizado com sucesso'
    expect(page).to have_content 'Nome fantasia: Spock'
    expect(page).to have_content 'Nome companhia: Spock Restaurantes'
    expect(page).to have_content "CNPJ: #{cnpj}"
    expect(page).to have_content 'Endereço: Rua Ana Maria, 1050'
    expect(page).to have_content 'Telefone: 1199889988'
    expect(page).to have_content 'E-mail: spock@email.com'
  end
  
  it "e mantém os campos obrigatórios" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user, scope: :user)
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'Nome companhia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o Estabelecimento'
  end
  
end