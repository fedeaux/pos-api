require 'rails_helper'

RSpec.describe Table, type: :model do
  describe '.create' do
    it 'cannot be directly created' do
      expect{ Table.create }.to raise_error 'Table.create is disabled, use Table.ensure_amount instead'
    end

    it 'can be created with Table.ensure_amount' do
      expect{ Table.ensure_amount 5 }.to change{ Table.count }.by(5)
      expect{ Table.ensure_amount 5 }.to change{ Table.count }.by(0)
      expect{ Table.ensure_amount 3 }.to change{ Table.count }.by(0)
      expect{ Table.ensure_amount(-5) }.to change{ Table.count }.by(0)
      expect{ Table.ensure_amount(11) }.to change{ Table.count }.by(6)
    end
  end

  describe '#state' do
    let(:table) {
      Table.ensure_amount(1)
      Table.first
    }

    it 'is Table::AVAILABLE by default' do
      expect(table.state).to eq Table::AVAILABLE
    end

    it 'defaults to Table::AVAILABLE if set to an invalid state' do
      table.state = 'with people dancing on'
      expect(table.state).to eq Table::AVAILABLE
    end

    it 'can be set to valid state: Table::DISABLED' do
      table.state = Table::DISABLED
      expect(table.state).to eq Table::DISABLED
    end

    it 'can be set to valid state: Table::OCCUPIED' do
      table.state = Table::OCCUPIED
      expect(table.state).to eq Table::OCCUPIED
    end
  end
end
