require 'rails_helper'

describe "Usuário cria uma conta" do
  it "com sucesso" do
    cpf = CPF.generate

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in "Nome",	with: "Maria" 
    fill_in "CPF",	with: cpf 
    fill_in "E-mail",	with: "maria@email.com" 
    fill_in "Senha",	with: "password1234" 
    fill_in "Confirme sua senha",	with: "password1234" 
    click_on 'Criar conta'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'maria@email.com'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Maria'
  end

  it "com dados incompletos" do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in "Nome",	with: "" 
    fill_in "CPF",	with: "" 
    fill_in "E-mail",	with: "" 
    fill_in "Senha",	with: "" 
    fill_in "Confirme sua senha",	with: "" 
    click_on 'Criar conta'

    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end