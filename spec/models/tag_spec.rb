require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "#valid?" do
    it "estabelecimento é obrigatório" do
      tag = Tag.new(establishment: nil)

      tag.valid?
      result = tag.errors

      expect(result.include?(:establishment)).to be true
      expect(result[:establishment]).to include 'é obrigatório(a)'
    end
  end
end