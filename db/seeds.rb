ActiveRecord::Base.transaction do
  
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
  
  # Novo funcionario
  cpf_employee = CPF.generate
  pre_registration = PreRegistration.create!(cpf: cpf_employee, email: "kurt@email.com", establishment: establishment, used: true)
  employee = Employee.create!(name: 'Kurt Donald Cobain', email: "kurt@email.com", cpf: cpf_employee, establishment: establishment, password: 'password1234')
  
  # Horas de trabalho
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :monday, opening_time: "18:00", closing_time: "22:00", closed: true)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :tuesday, opening_time: "18:00", closing_time: "22:00", closed: true)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :wednesday, opening_time: "18:00", closing_time: "22:00", closed: false)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :thursday, opening_time: "18:00", closing_time: "22:00", closed: false)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :friday, opening_time: "18:00", closing_time: "22:00", closed: false)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :saturday, opening_time: "18:00", closing_time: "23:00", closed: false)
  hours_operations = HoursOperation.create!(establishment: establishment, weekday: :sunday, opening_time: "18:00", closing_time: "23:00", closed: false)

  # Marcadores
  Tag.create!(name: 'sem glúten', establishment: establishment)
  Tag.create!(name: 'vegetariano', establishment: establishment)
  Tag.create!(name: 'apimentado', establishment: establishment)
  
  # Cardápios
  menu_rock_classics = Menu.create!(name: 'Rock Classics', establishment: establishment)
  menu_breakfast = Menu.create!(name: 'Café da Manhã', establishment: establishment)
  menu_executive_lunch = Menu.create!(name: 'Almoço Executivo', establishment: establishment)
  
  # Pratos
  dish = Dish.create!(name: 'Bohemian Burger', description: 'Burger com carne de angus, queijo cheddar, alface, tomate e molho especial', calories: 850, establishment: establishment, status: 'enabled')
  dish.image.attach(io: File.open('./app/assets/images/bohemian_burger.jpg'), filename: "bohemian_burger.jpg", content_type: "image/jpeg")
  dish2 = Dish.create!(name: 'Radio Fries', description: 'Batatas fritas temperadas com alho e ervas', calories: 400, establishment: establishment, status: 'enabled')
  dish2.image.attach(io: File.open('./app/assets/images/radio_fries.jpg'), filename: "radio_fries.jpg", content_type: "image/jpeg")
  
  # Bebidas
  drink = Drink.create!(name: 'Killer Lemonade', description: 'Limonada refrescante com toque de hortelã', calories: 120, establishment: establishment, alcoholic: false, status: 'enabled')
  drink.image.attach(io: File.open('./app/assets/images/killer_lemonade.jpg'), filename: "killer_lemonade.jpg", content_type: "image/jpeg")
  drink2 = Drink.create!(name: 'Rusty Ale', description: 'Cerveja artesanal com sabor encorpado', calories: 220, establishment: establishment, alcoholic: true, status: 'enabled')
  drink2.image.attach(io: File.open('./app/assets/images/rusty_ale.jpg'), filename: "rusty_ale.jpg", content_type: "image/jpeg")
  
  # Porções Rock Classics dishes
  portion_dish_1 = Portion.create!(description: 'Porção pequena', real: 12, cent: 0, portionable: dish)
  portion_dish_2 = Portion.create!(description: 'Porção grande', real: 20, cent: 0, portionable: dish)
  portion_dish2_1 = Portion.create!(description: 'Porção pequena', real: 8, cent: 0, portionable: dish2)
  portion_dish2_2 = Portion.create!(description: 'Porção grande', real: 14, cent: 0, portionable: dish2)
  
  # Portions Rock Classics drinks
  portion_drink_1 = Portion.create!(description: 'Copo [300ml]', real: 5, cent: 0, portionable: drink)
  portion_drink_2 = Portion.create!(description: 'Jarra [1 litro]', real: 12, cent: 0, portionable: drink)
  portion_drink2_1 = Portion.create!(description: 'Copo [300ml]', real: 7, cent: 0, portionable: drink2)
  portion_drink2_2 = Portion.create!(description: 'Garrafa [500ml]', real: 15, cent: 0, portionable: drink2)
  
  # Breakfast dishes
  breakfast_dish1 = Dish.create!(name: 'Freddie\'s Toast', description: 'Torrada com ovos mexidos e bacon', calories: 350, establishment: establishment, status: 'enabled')
  breakfast_dish1.image.attach(io: File.open('./app/assets/images/freddies_toast.jpg'), filename: "freddies_toast.jpg", content_type: "image/jpeg")
  breakfast_dish2 = Dish.create!(name: 'Mercury Pancakes', description: 'Panquecas com calda e frutas', calories: 450, establishment: establishment, status: 'enabled')
  breakfast_dish2.image.attach(io: File.open('./app/assets/images/pancakes.jpg'), filename: "pancakes.jpg", content_type: "image/jpeg")
  breakfast_drink = Drink.create!(name: 'Good Old Fashioned Coffee', description: 'Café preto tradicional', calories: 5, establishment: establishment, alcoholic: false, status: 'enabled')
  breakfast_drink.image.attach(io: File.open('./app/assets/images/coffe.jpg'), filename: "coffe.jpg", content_type: "image/jpeg")
  
  # Executive lunch dishes
  lunch_dish1 = Dish.create!(name: 'Queen’s Deluxe Salad', description: 'Salada com mix de folhas, tomate cereja e nozes', calories: 300, establishment: establishment, status: 'enabled')
  lunch_dish1.image.attach(io: File.open('./app/assets/images/salad.jpg'), filename: "salad.jpg", content_type: "image/jpeg")
  lunch_dish2 = Dish.create!(name: 'Champion Grilled Steak', description: 'Filé grelhado com legumes ao vapor', calories: 600, establishment: establishment, status: 'enabled')
  lunch_dish2.image.attach(io: File.open('./app/assets/images/champion_steak.jpg'), filename: "champion_steak.jpg", content_type: "image/jpeg")
  lunch_drink = Drink.create!(name: 'Under Pressure Soda', description: 'Refrigerante artesanal de gengibre', calories: 150, establishment: establishment, alcoholic: false, status: 'enabled')
  lunch_drink.image.attach(io: File.open('./app/assets/images/soda.jpg'), filename: "soda.jpg", content_type: "image/jpeg")
  
  # Portions for Breakfast and Executive Lunch dishes
  portion_breakfast_dish1 = Portion.create!(description: 'Porção única', real: 15, cent: 0, portionable: breakfast_dish1)
  portion_breakfast_dish2 = Portion.create!(description: 'Porção única', real: 18, cent: 0, portionable: breakfast_dish2)
  portion_breakfast_drink = Portion.create!(description: 'Copo [200ml]', real: 3, cent: 0, portionable: breakfast_drink)
  
  portion_lunch_dish1 = Portion.create!(description: 'Porção única', real: 22, cent: 0, portionable: lunch_dish1)
  portion_lunch_dish2 = Portion.create!(description: 'Porção única', real: 35, cent: 0, portionable: lunch_dish2)
  portion_lunch_drink = Portion.create!(description: 'Copo [300ml]', real: 6, cent: 0, portionable: lunch_drink)
  
  # itens de cardápios
  MenuItem.create!(menu: menu_rock_classics, menuable: dish)
  MenuItem.create!(menu: menu_rock_classics, menuable: dish2)
  MenuItem.create!(menu: menu_rock_classics, menuable: drink)
  MenuItem.create!(menu: menu_rock_classics, menuable: drink2)
  
  MenuItem.create!(menu: menu_breakfast, menuable: breakfast_dish1)
  MenuItem.create!(menu: menu_breakfast, menuable: breakfast_dish2)
  MenuItem.create!(menu: menu_breakfast, menuable: breakfast_drink)
  
  MenuItem.create!(menu: menu_executive_lunch, menuable: lunch_dish1)
  MenuItem.create!(menu: menu_executive_lunch, menuable: lunch_dish2)
  MenuItem.create!(menu: menu_executive_lunch, menuable: lunch_drink)
  
  # Pedidos
  order = Order.create!(name: 'José de Andrade', phone: '1122332233', email: 'jose@email', cpf: CPF.generate,
    code: 'ABCD1234', status: 'waiting', establishment: establishment)
  OrderItem.create!(order: order, orderable:dish, portion: portion_dish_1, note: 'sem cebola')
  
  order2 = Order.create!(name: 'Maria Silva', phone: '1144554455', email: 'maria@email', cpf: CPF.generate,
    code: 'ABCD5678', status: 'in_preparation', establishment: establishment)
  OrderItem.create!(order: order2, orderable:dish, portion: portion_dish_1, note: 'com cebola')
  
  order3 = Order.create!(name: 'Andre Soares', phone: '1155664466', email: 'andre@email', cpf: CPF.generate,
    code: 'ABCD9876', status: 'waiting', establishment: establishment)
  OrderItem.create!(order: order3, orderable:dish, portion: portion_dish_1, note: 'com cebola')
  OrderItem.create!(order: order3, orderable:drink, portion: portion_drink_2, note: 'com gelo')

end  
