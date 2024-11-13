require 'rails_helper'

describe "usuário se autentica" do
  it "com sucesso" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      user: user )

    visit root_path
    click_on 'Dono'
    within 'form' do
      fill_in "E-mail",	with: "joao@email.com" 
      fill_in "Senha",	with: "password1234" 
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do
      expect(page).not_to have_link 'Dono'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'joao@email.com'
    end
  end

  it "e faz logout" do
    cpf = CPF.generate
    User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    
    visit root_path
    click_on 'Dono'
    within 'form' do
      fill_in "E-mail",	with: "joao@email.com" 
      fill_in "Senha",	with: "password1234" 
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Dono'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joao@email.com'
  end
end