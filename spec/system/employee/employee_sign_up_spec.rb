require 'rails_helper'

describe "Funcionário cria uma conta" do
  it "com sucesso" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      user: user )
    cpf = CPF.generate
    pre_registration = PreRegistration.create!(email: "maria@email.com", cpf: cpf, establishment: establishment)

    visit root_path
    click_on 'Funcionário'
    click_on 'Criar uma conta'
    fill_in "Nome",	with: "Maria" 
    fill_in "CPF",	with: cpf
    fill_in "E-mail",	with: "maria@email.com" 
    fill_in "Senha",	with: "password1234" 
    fill_in "Confirme sua senha",	with: "password1234" 
    click_on 'Criar conta'

    expect(page).to have_content "Funcionário cadastro com sucesso."
    expect(page).to have_content 'maria@email.com'
    employee = Employee.last
    expect(employee.name).to eq 'Maria'
    expect(page).to have_button 'Sair'
    pre_reg = PreRegistration.last
    expect(pre_reg.used).to eq true
  end
end
