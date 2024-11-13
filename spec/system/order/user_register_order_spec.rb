require 'rails_helper'

describe "Usuário registra um pedido" do
  it "e vê botão Adicionar pedido" do
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
    portion_dish2_1 = Portion.create!(description: 'Porção pequena', real: 8, cent: 0, portionable: dish2)
    portion_dish2_2 = Portion.create!(description: 'Porção Grande', real: 16, cent: 0, portionable: dish2)
    portion_drink_1 = Portion.create!(description: 'Copo [250ml]', real: 4, cent: 0, portionable: drink)
    portion_drink_2 = Portion.create!(description: 'Jarra [1litro]', real: 8, cent: 0, portionable: drink)
    MenuItem.create!(menu: menu, menuable:dish)
    MenuItem.create!(menu: menu, menuable:dish2)
    MenuItem.create!(menu: menu, menuable:drink)

    login_as(user, scope: :user)
    visit menus_path
    click_on 'Café da Manhã'

    within("#menu_item_1") do
      expect(page).to have_link 'Adicionar Pedido'
    end
    within("#menu_item_2") do
      expect(page).to have_link 'Adicionar Pedido'
    end
  end

  it "e adicionar itens ao pedido" do
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
    portion_dish2_1 = Portion.create!(description: 'Porção pequena', real: 8, cent: 0, portionable: dish2)
    portion_dish2_2 = Portion.create!(description: 'Porção Grande', real: 16, cent: 0, portionable: dish2)
    portion_drink_1 = Portion.create!(description: 'Copo [250ml]', real: 4, cent: 0, portionable: drink)
    portion_drink_2 = Portion.create!(description: 'Jarra [1litro]', real: 8, cent: 0, portionable: drink)
    MenuItem.create!(menu: menu, menuable:dish)
    MenuItem.create!(menu: menu, menuable:dish2)
    MenuItem.create!(menu: menu, menuable:drink)

    login_as(user, scope: :user)
    visit menus_path
    click_on 'Café da Manhã'
    within("#menu_item_1") do
      click_on 'Adicionar Pedido'
    end
    select "Porção pequena: R$ 5,00", from: "Porção" 
    fill_in "Observações", with: "sem cebola" 
    click_on 'Adicionar'

    expect(current_path).to eq menu_path(1)
  end

  it "e vê pagina para finalizar pedido" do
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
    portion_dish2_1 = Portion.create!(description: 'Porção pequena', real: 8, cent: 0, portionable: dish2)
    portion_dish2_2 = Portion.create!(description: 'Porção Grande', real: 16, cent: 0, portionable: dish2)
    portion_drink_1 = Portion.create!(description: 'Copo [250ml]', real: 4, cent: 0, portionable: drink)
    portion_drink_2 = Portion.create!(description: 'Jarra [1litro]', real: 8, cent: 0, portionable: drink)
    MenuItem.create!(menu: menu, menuable:dish)
    MenuItem.create!(menu: menu, menuable:dish2)
    MenuItem.create!(menu: menu, menuable:drink)
    order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
    order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
    order_item = OrderItem.create!(order: order, orderable:drink, portion: portion_drink_1, note: 'com gelo')

    login_as(user, scope: :user)
    visit menus_path
    click_on 'Café da Manhã'
    within("#menu_item_1") do
      click_on 'Adicionar Pedido'
    end
    select "Porção pequena: R$ 5,00", from: "Porção" 
    fill_in "Observações", with: "sem cebola" 
    click_on 'Adicionar'
    within("#menu_item_3") do
      click_on 'Adicionar Pedido'
    end
    select "Copo [250ml]: R$ 4,00", from: "Porção" 
    fill_in "Observações", with: "com gelo" 
    click_on 'Adicionar'
    click_on 'Finalizar Pedido'

    expect(page).to have_content 'Novo Pedido'
    expect(page).to have_content 'Sanduíche'
    expect(page).to have_content 'Porção pequena: R$ 5,00'
    expect(page).to have_content 'Suco de Laranja'
    expect(page).to have_content 'Copo [250ml]: R$ 4,00'
    expect(page).to have_content 'Total: R$ 9.00'
    expect(page).to have_field 'Nome Cliente'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'CPF'
    expect(page).to have_button 'Enviar'
  end
end