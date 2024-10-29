require 'rails_helper'

RSpec.describe HoursOperation, type: :model do
  describe "#Valid?" do
    it 'validates presence of weekday' do
      hours_operation = HoursOperation.new(opening_time: '09:00', closing_time: '17:00', closed: false)
      expect(hours_operation).to be_invalid
      expect(hours_operation.errors[:weekday]).to include("não pode ficar em branco")
    end

    it 'validates presence of opening_time' do
      hours_operation = HoursOperation.new(weekday: 1, closing_time: '17:00', closed: false)
      expect(hours_operation).to be_invalid
      expect(hours_operation.errors[:opening_time]).to include("não pode ficar em branco")
    end

    it 'validates presence of closing_time' do
      hours_operation = HoursOperation.new(weekday: 1, opening_time: '09:00', closed: false)
      expect(hours_operation).to be_invalid
      expect(hours_operation.errors[:closing_time]).to include("não pode ficar em branco")
    end

    it 'validates presence of closed' do
      hours_operation = HoursOperation.new(weekday: 1, opening_time: '09:00', closing_time: '17:00')
      expect(hours_operation).to be_invalid
      expect(hours_operation.errors[:closed]).to include("não está incluído na lista")
    end
  end
end