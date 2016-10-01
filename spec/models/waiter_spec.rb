require 'rails_helper'

RSpec.describe Waiter, type: :model do
  describe 'factories' do
    it 'has valid factories' do
      expect(create :waiter_alfred).to be_valid
      expect(create :waiter_robin).to be_valid
      expect(create :waitress_amelia).to be_valid
    end
  end

  describe 'validations' do
    let(:waiter_attributes) { attributes_for :waiter_alfred }

    it 'is invalid without a name' do
      expect(Waiter.create waiter_attributes.except(:name)).to be_invalid
    end
  end
end
