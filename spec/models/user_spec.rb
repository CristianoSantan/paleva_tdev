require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "presença" do
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
    end
  end
end
