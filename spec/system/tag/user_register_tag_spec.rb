require 'rails_helper'

describe "usuário cadastra marcadores" do
  it "e vê tela com formulario" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Cadastrar Marcadores'

    expect(page).to have_content 'Novo Marcador'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Enviar'
  end

  it "previamente com sucesso" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Cadastrar Marcadores'
    fill_in "Nome",	with: "sem glúten"
    click_on 'Enviar'

    expect(page).to have_content 'Marcador cadastrado com sucesso.'
    marcador = Tag.last
    expect(marcador.name).to eq 'sem glúten'
    expect(page).to have_content 'Marcadores: sem glúten |'
  end

  # it "previamente com erro" do
  #   user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
  #   establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
  #     full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )

  #   login_as(user, scope: :user)
  #   visit root_path
  #   within('nav') do
  #     click_on 'Estabelecimento'
  #   end
  #   click_on 'Cadastrar Marcadores'
  #   fill_in "Nome",	with: ""
  #   click_on 'Enviar'

  #   expect(page).to have_content 'Marcador não cadastrado.'
  #   marcador = Tag.last
  #   expect(marcador).to eq nil
  # end

  it "ao cadastrar prato", js: true do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', 
      code: 'ABC123', user: user )
  
    login_as(user, scope: :user)
    visit dishes_path
    click_on 'Cadastrar Prato'
    within '#name_dish' do
      fill_in "Nome",	with: "Frango" 
    end
    fill_in "Descrição",	with: "assado" 
    fill_in "Calorias",	with: "250" 
    fill_in "Marcador 1",	with: "apimentado" 
    click_on "Enviar"

    expect(page).to have_content 'Prato cadastrado com sucesso.'
    expect(page).to have_content 'Frango'
    expect(page).to have_content 'Marcadores: apimentado'
  end
end