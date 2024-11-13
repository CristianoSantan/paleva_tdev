require 'rails_helper'

describe "Usuário vê os marcadores" do
  it "e não acessa sem estar autenticado" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    tag = Tag.create!(name: 'sem glúten', establishment: establishment)

    visit root_path
    visit new_tag_path

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it "na tela do estabelecimento" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    tag = Tag.create!(name: 'sem glúten', establishment: establishment)

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end

    expect(page).to have_content 'Marcadores: sem glúten'
  end

  it "no prato cadastrado" do
    user = User.create!(name: 'João Silva', cpf: CPF.generate, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: CNPJ.generate,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    tag = Tag.create!(name: 'apimentada', establishment: establishment)
    dish_tag = DishTag.create!(dish: dish, tag: tag)

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'

    expect(page).to have_content 'Marcadores: apimentada'
  end
end