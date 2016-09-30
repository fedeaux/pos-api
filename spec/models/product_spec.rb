require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factories' do
    it 'has valid factories' do
      expect(create :product_drink).to be_valid
      expect(create :product_food).to be_valid
    end
  end

  describe 'validations' do
    let(:product_attributes) { attributes_for :product_food }

    it 'is invalid without a name' do
      expect(Product.create product_attributes.except(:name)).to be_invalid
    end

    it 'is invalid without a code' do
      expect(Product.create product_attributes.except(:code)).to be_invalid
    end

    it 'is invalid without a price' do
      expect(Product.create product_attributes.except(:price)).to be_invalid
    end

    it 'is invalid without a category' do
      expect(Product.create product_attributes.except(:category)).to be_invalid
    end

    it 'is invalid with a negative price' do
      expect(Product.create product_attributes.merge(price: -1)).to be_invalid
    end
  end

  describe 'scopes' do
    it 'can retrieve only active products' do
      create :product_drink
      create :product_food, active: false

      expect(Product.active.count).to eq 1
    end
  end
end
