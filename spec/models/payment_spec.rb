require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:consumption) {
    Table.ensure_amount 1
    table = Table.first
    table.update state: Table::OCCUPIED
    table.active_consumption
  }

  describe 'validations' do
    it 'is valid with consumption and positive value' do
      expect(Payment.create value: 3.99, consumption: consumption).to be_valid
    end

    it 'is invalid without consumption' do
      expect(Payment.create value: 6.99).to be_invalid
    end

    it 'is invalid without a value' do
      expect(Payment.create consumption: consumption).to be_invalid
    end

    it 'is invalid with a negative value' do
      expect(Payment.create consumption: consumption, value: -12.0).to be_invalid
    end
  end
end
