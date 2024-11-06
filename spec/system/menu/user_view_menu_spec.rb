require 'rails_helper'

describe "Usuário vê cardárpios" do
  it "em lista de cardárpios e vê o botão para cadastrar cardápio" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)

    login_as(user)
    visit menus_path

    expect(current_path).to eq menus_path
    expect(page).to have_content 'Cardápios de pizzafire'
    expect(page).to have_link 'Cadastrar Cardápio'
    expect(page).to have_content 'Café da Manhã'
  end
end
