require 'rails_helper'

describe "Usuário vê pré-cadastro" do
  it "de funcionários não utilizado" do
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
    pre_registration = PreRegistration.create!(cpf: CPF.generate, email: "kurt@email.com", establishment: establishment, used: false)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Pré-cadastros'

    expect(page).to have_current_path pre_registrations_path
    within 'table' do
      expect(page).to have_content 'E-mail'
      expect(page).to have_content 'CPF'
      expect(page).to have_content 'Cadastro'
    end
    expect(page).to have_content 'kurt@email.com'
    expect(page).to have_content pre_registration.cpf
    expect(page).to have_content 'Não utilizado'
  end

  it "de funcionários utilizado" do
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
    pre_registration = PreRegistration.create!(cpf: cpf_employee, email: "kurt@email.com", establishment: establishment)

    visit root_path
    click_on 'Funcionário'
    click_on 'Criar uma conta'
    fill_in "Nome",	with: "Kurt Donald Cobain" 
    fill_in "CPF",	with: cpf_employee
    fill_in "E-mail",	with: "kurt@email.com" 
    fill_in "Senha",	with: "password1234" 
    fill_in "Confirme sua senha",	with: "password1234" 
    click_on 'Criar conta'
    click_on 'Sair'
    login_as(user, scope: :user)
    visit root_path
    click_on 'Pré-cadastros'

    expect(page).to have_content 'kurt@email.com'
    expect(page).to have_content cpf_employee
    pre_reg = PreRegistration.last
    expect(pre_reg.used).to eq true
    expect(page).to have_content 'Utilizado'
  end
end