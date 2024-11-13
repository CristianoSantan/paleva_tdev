require 'rails_helper'

describe "Usuário vê as horas de funcionamento" do
  it "e vê a tabela em estabelecimentos" do
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

    expect(page).to have_content 'Dia da semana'
    expect(page).to have_content 'Abertura'
    expect(page).to have_content 'Fechamento'
    expect(page).to have_content 'Fechado'
  end
  
  it "e ve os horarios" do
    cpf = CPF.generate
    cnpj = CNPJ.generate
    user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
    establishment = Establishment.create!(brand_name: 'pizzafire', company_name: 'pizzafire restaurantes', cnpj: cnpj,
      full_address: 'Rua Dom Pedro, 280', phone: '1122332233', email: 'pizzafire@email.com', user: user )
    hours_operations = HoursOperation.create!(establishment: establishment, weekday: :monday, 
      opening_time: "18:00", closing_time: "22:00", closed: false)

    login_as(user, scope: :user)
    visit root_path
    within('nav') do
      click_on 'Estabelecimento'
    end

    expect(page).to have_content 'Dia da semana'
    expect(page).to have_content 'segunda-feira'
  end
end
