require 'rails_helper'

RSpec.describe 'Consumption and Product interaction', type: :model do
  let(:table) {
    Table.ensure_amount 1
    Table.first
  }

  let(:food_599) {
    create(:product_food, price: 5.99)
  }

  let(:food_729) {
    create(:product_food, price: 7.29)
  }

  it 'automatically sets total_price when adding or removing products' do
    table.update state: Table::OCCUPIED
    consumption = table.active_consumption

    consumption.products << food_599
    consumption.save
    expect(consumption.total_price).to eq food_599.price

    consumption.products << food_599
    consumption.save
    expect(consumption.total_price).to eq food_599.price * 2

    consumption.products << food_729
    consumption.save
    expect(consumption.total_price).to eq food_599.price * 2 + food_729.price

    consumption.remove_one_product food_599
    expect(consumption.total_price).to eq food_599.price + food_729.price
  end
end
