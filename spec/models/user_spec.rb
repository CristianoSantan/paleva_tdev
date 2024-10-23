require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    it "falso quando nome vazio" do
      user = User.new(name: '', cpf: '12345678910', email: 'joao@email.com', password: 'password1234')
      expect(user).not_to be_valid 
    end

    it "falso quando cpf vazio" do
      user = User.new(name: 'João Silva', cpf: '', email: 'joao@email.com', password: 'password1234')
      expect(user).not_to be_valid 
    end

    it "falso quando email vazio" do
      user = User.new(name: 'João Silva', cpf: '12345678910', email: '', password: 'password1234')
      expect(user).not_to be_valid 
    end

    it "falso quando senha vazio" do
      user = User.new(name: 'João Silva', cpf: '12345678910', email: 'joao@email.com', password: '')
      expect(user).not_to be_valid 
    end

    it "cpf não possui o tamanho esperado" do
      user = User.new(cpf: '123654')
    
      user.valid?
      result = user.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'não possui o tamanho esperado (11 caracteres)'
    end

    it "cpf com número inválido" do
      user = User.new(cpf: '35612345610')
    
      user.valid?
      result = user.errors

      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'deve ser válido'
    end
    
    it "cpf com número válido" do
      cpf = CPF.generate
      
      user = User.new(cpf: cpf)
      
      user.valid?
      result = user.errors
      expect(result.include?(:cpf)).to be false
    end
    
    it "cpf é único" do
      cpf = CPF.generate
      first_user = User.create!(name: 'João Silva', cpf: cpf, email: 'joao@email.com', password: 'password1234')
      second_user = User.new(name: 'Maria', cpf: cpf, email: 'maria@email.com', password: 'password1234')
      
      second_user.valid?
      result = second_user.errors
      
      expect(result.include?(:cpf)).to be true
      expect(result[:cpf]).to include 'já está em uso'
    end
    
  end
end
