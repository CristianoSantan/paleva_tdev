require 'rails_helper'

describe "Order API" do
  context "GET /api/v1/orders/:establishment_code" do
    it "list all orders" do
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
      menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
      dish = Dish.create!(name: 'Bohemian Rhapsody Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
      portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
      portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
      MenuItem.create!(menu: menu_rock_classics, menuable: dish)
      order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
      order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
      order2 = Order.create!(name: 'Maria', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
      code: 'ABCD5678', status: 'waiting', establishment: establishment)
      order_item2 = OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')

      get '/api/v1/orders/QUEEN01'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "José"
      expect(json_response[0]["order_items"][0]["note"]).to eq "sem cebola"
      expect(json_response[1]["name"]).to eq "Maria"
      expect(json_response[1]["order_items"][0]["note"]).to eq "com cebola"
    end

    it "list all orders without params status" do
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
      menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
      dish = Dish.create!(name: 'Bohemian Rhapsody Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
      portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
      portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
      MenuItem.create!(menu: menu_rock_classics, menuable: dish)
      order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
      order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
      order2 = Order.create!(name: 'Maria', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
      code: 'ABCD5678', status: 'waiting', establishment: establishment)
      order_item2 = OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')

      get '/api/v1/orders/QUEEN01', params: { status: "" }

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "José"
      expect(json_response[0]["order_items"][0]["note"]).to eq "sem cebola"
      expect(json_response[1]["name"]).to eq "Maria"
      expect(json_response[1]["order_items"][0]["note"]).to eq "com cebola"
    end

    it "list all orders with params of establishment and filter by status" do
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
      menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
      dish = Dish.create!(name: 'Bohemian Rhapsody Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
      portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
      portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
      MenuItem.create!(menu: menu_rock_classics, menuable: dish)
      order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
      order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
      order2 = Order.create!(name: 'Maria', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
      code: 'ABCD5678', status: 'ready', establishment: establishment)
      order_item2 = OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')

      get '/api/v1/orders/QUEEN01', params: { status: "ready" }

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response[0]["name"]).to eq "Maria"
      expect(json_response[0]["order_items"][0]["note"]).to eq "com cebola"
    end
  end

  context "GET /api/v1/orders/:establishment_code/:order_code" do
    it "secesso" do
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
      menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
      dish = Dish.create!(name: 'Bohemian Rhapsody Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
      portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
      portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
      MenuItem.create!(menu: menu_rock_classics, menuable: dish)
      order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
      order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
      order2 = Order.create!(name: 'Maria', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
      code: 'ABCD5678', status: 'ready', establishment: establishment)
      order_item2 = OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')

      get "/api/v1/orders/QUEEN01/#{order2.code}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Hash
      expect(json_response["name"]).to eq "Maria"
      expect(json_response["order_items"][0]["note"]).to eq "com cebola"
    end
  end
  
  context "PATCH /api/v1/orders/:establishment_code/:order_code" do
    it "update status of order" do
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
      menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
      dish = Dish.create!(name: 'Bohemian Rhapsody Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
      portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
      portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
      MenuItem.create!(menu: menu_rock_classics, menuable: dish)
      order = Order.create!(name: 'José', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
      code: 'ABCD1234', status: 'waiting', establishment: establishment)
      order_item = OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
      order2 = Order.create!(name: 'Maria', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
      code: 'ABCD5678', status: 'ready', establishment: establishment)
      order_item2 = OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')

      patch "/api/v1/orders/QUEEN01/#{order.code}/?status=in_preparation"

      expect(response.status).to eq 201
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Hash
      expect(json_response["status"]).to eq "in_preparation"
    end
  end
  
end