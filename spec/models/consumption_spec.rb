require 'rails_helper'

RSpec.describe Consumption, type: :model do
  describe '#state' do
    let(:consumption) {
      Table.ensure_amount(1)
      Consumption.create table: Table.first
    }

    it 'is Consumption::OPEN by default' do
      expect(consumption.state).to eq Consumption::OPEN
    end

    it 'defaults to Consumption::OPEN if set to an invalid state' do
      consumption.state = 'with people dancing on'
      expect(consumption.state).to eq Consumption::OPEN
    end

    it 'can be set to valid state: Consumption::PAYED' do
      consumption.state = Consumption::PAYED
      expect(consumption.state).to eq Consumption::PAYED
    end

    it 'can be set to valid state: Consumption::OCCUPIED' do
      consumption.state = Consumption::CANCELED
      expect(consumption.state).to eq Consumption::CANCELED
    end
  end
end
