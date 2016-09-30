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
end
