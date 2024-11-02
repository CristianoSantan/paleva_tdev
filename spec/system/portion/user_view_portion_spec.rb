require 'rails_helper'

describe "Usuário ve as porções" do
  it "de pratos" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    dish = Dish.create!(name: 'Batata Frita', description: 'rústica', calories: 300, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Porção Pequena', real: 20, cent: 0, portionable: dish)
    portion_2 = Portion.create!(description: 'Porção Grande', real: 35, cent: 0, portionable: dish)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Pratos'
    click_on 'Batata Frita'

    expect(page).to have_content 'Porções'
    expect(page).to have_content 'Porção Pequena:'
    expect(page).to have_content 'R$ 20,00'
    expect(page).to have_content 'Porção Grande:'
    expect(page).to have_content 'R$ 35,00'
  end
  
  it "de bebidas" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', code: 'ABC123', user: user )
    drink = Drink.create!(name: 'Coca Cola Zero', description: 'zero açucar', calories: 300, alcoholic: false, establishment: establishment, status: 'enabled')
    portion_1 = Portion.create!(description: 'Lata (350ml)', real: 5, cent: 0, portionable: drink)
    portion_2 = Portion.create!(description: 'Garrafa (600ml)', real: 9, cent: 0, portionable: drink)
    portion_3 = Portion.create!(description: 'Garrafa (1 litro)', real: 12, cent: 0, portionable: drink)
    
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end
    click_on 'Bebidas'
    click_on 'Coca Cola Zero'

    expect(page).to have_content 'Porções'
    expect(page).to have_content 'Lata (350ml):'
    expect(page).to have_content 'R$ 5,00'
    expect(page).to have_content 'Garrafa (600ml):'
    expect(page).to have_content 'R$ 9,00'
    expect(page).to have_content 'Garrafa (1 litro):'
    expect(page).to have_content 'R$ 12,00'
  end
end
