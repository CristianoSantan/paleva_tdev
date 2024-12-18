require 'rails_helper'

describe "Usuário vê a página do estabelecimento" do
  it "se estiver autenticado" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      user: user )

    visit establishment_path(1)

    expect(current_path).to eq new_user_session_path 
  end

  it "a partir do menu" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end

    expect(current_path).to eq establishment_path(user.id)
    expect(page).to have_content 'Estabelecimento'
    expect(page).to have_content "Código: #{establishment.code}"
    expect(page).to have_link 'Pratos'
    expect(page).to have_link 'Bebidas'
  end
end