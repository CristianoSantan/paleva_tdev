require 'rails_helper'

describe "Usuário registra um pré cadastro de funcionario" do
  it "e vê os campos obrigatórios" do
    user = User.create!(name: 'Freddie Mercury', cpf: CPF.generate, email: 'freddie@burgerqueen.com', password: 'password1234')
    establishment = Establishment.create!(
      brand_name: 'BurgerQueen',
      company_name: 'BurgerQueen Rock n\' Roll Restaurants',
      cnpj: CNPJ.generate,
      full_address: 'Rua Rock, 280',
      phone: '11987654321',
      email: 'contact@burgerqueen.com',
      code: 'QUEEN01',
      user: user
    )

    login_as(user, scope: :user)
    visit root_path
    click_on 'Pré-cadastros'
    click_on 'Adicionar Funcionário'

    expect(page).to have_content 'Novo pré-cadastro'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'CPF'
  end

  it "com sucesso" do
    user = User.create!(name: 'Freddie Mercury', cpf: CPF.generate, email: 'freddie@burgerqueen.com', password: 'password1234')
    establishment = Establishment.create!(
      brand_name: 'BurgerQueen',
      company_name: 'BurgerQueen Rock n\' Roll Restaurants',
      cnpj: CNPJ.generate,
      full_address: 'Rua Rock, 280',
      phone: '11987654321',
      email: 'contact@burgerqueen.com',
      code: 'QUEEN01',
      user: user
    )

    cpf_employee = CPF.generate

    login_as(user, scope: :user)
    visit root_path
    click_on 'Pré-cadastros'
    click_on 'Adicionar Funcionário'
    fill_in 'E-mail',	with: "kurt@email.com"
    fill_in 'CPF',	with: cpf_employee
    click_on 'Enviar'

    expect(page).to have_content 'Pré-cadastro criado com sucesso.'
    expect(page).to have_content 'kurt@email.com'
    expect(page).to have_content cpf_employee
    expect(page).to have_content 'Não utilizado'
  end

  it "faltando informações" do
    user = User.create!(name: 'Freddie Mercury', cpf: CPF.generate, email: 'freddie@burgerqueen.com', password: 'password1234')
    establishment = Establishment.create!(
      brand_name: 'BurgerQueen',
      company_name: 'BurgerQueen Rock n\' Roll Restaurants',
      cnpj: CNPJ.generate,
      full_address: 'Rua Rock, 280',
      phone: '11987654321',
      email: 'contact@burgerqueen.com',
      code: 'QUEEN01',
      user: user
    )

    login_as(user, scope: :user)
    visit root_path
    click_on 'Pré-cadastros'
    click_on 'Adicionar Funcionário'
    fill_in 'E-mail',	with: ""
    fill_in 'CPF',	with: ""
    click_on 'Enviar'

    expect(page).to have_content 'Pré-cadastro não criado.'
    expect(page).to have_content 'Novo pré-cadastro'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'CPF'
  end
end