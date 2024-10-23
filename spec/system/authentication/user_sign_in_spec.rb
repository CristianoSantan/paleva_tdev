require 'rails_helper'

describe "usuário se autentica" do
  it "com sucesso" do
    User.create!(name: 'João Silva', cpf: '12345678910', email: 'joao@email.com', password: 'password1234')
    
    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in "E-mail",	with: "joao@email.com" 
      fill_in "Senha",	with: "password1234" 
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'joao@email.com'
    end
  end

  it "e faz logout" do
    User.create!(name: 'João Silva', cpf: '12345678910', email: 'joao@email.com', password: 'password1234')
    
    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in "E-mail",	with: "joao@email.com" 
      fill_in "Senha",	with: "password1234" 
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joao@email.com'
  end
end