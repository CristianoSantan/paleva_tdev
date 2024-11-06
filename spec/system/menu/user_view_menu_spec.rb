require 'rails_helper'

describe "Usuário vê cardárpios" do
  it "em lista de cardárpios" do
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

  it "e vê pratos e bebidas cadastradas" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    dish = Dish.create!(name: 'Sanduíche', description: 'pate de sardinha', calories: 300, establishment: establishment, status: 'enabled')
    dish2 = Dish.create!(name: 'Pão de Queijo', description: 'recheio doce de leite', calories: 300, establishment: establishment, status: 'enabled')
    drink = Drink.create!(name: 'Suco de Laranja', description: 'Laranja com água', calories: 180, establishment: establishment, alcoholic: false, status: 'enabled')
    portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 5, cent: 0, portionable: dish)
    portion_dish_2 = Portion.create!(description: 'Porção Grande', real: 10, cent: 0, portionable: dish)
    portion_dish2_1 = Portion.create!(description: 'Porção pequena', real: 5, cent: 0, portionable: dish2)
    portion_dish2_2 = Portion.create!(description: 'Porção Grande', real: 10, cent: 0, portionable: dish2)
    portion_drink_1 = Portion.create!(description: 'Copo [250ml]', real: 4, cent: 0, portionable: drink)
    portion_drink_2 = Portion.create!(description: 'Jarra [1litro]', real: 8, cent: 0, portionable: drink)
    MenuItem.create!(menu: menu, menuable:dish)
    MenuItem.create!(menu: menu, menuable:drink)

    login_as(user)
    visit menus_path
    click_on 'Café da Manhã'

    expect(page).to have_content 'Cardápio: Café da Manhã'
    expect(page).to have_content 'Sanduíche'
    expect(page).to have_content "Porção pequena - R$ 5,00"
    expect(page).to have_content "Porção Grande - R$ 10,00"
    expect(page).to have_content "Suco de Laranja"
    expect(page).to have_content "Copo [250ml] - R$ 4,00"
  end
end
