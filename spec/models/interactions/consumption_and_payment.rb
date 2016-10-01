require 'rails_helper'

RSpec.describe 'Consumption and Payment interaction', type: :model do
  let(:consumption) {
    Table.ensure_amount 1
    table = Table.first
    table.update state: Table::OCCUPIED
    table.active_consumption
  }

  let(:drink_999) {
    create(:product_drink, price: 9.99)
  }

  it 'automatically sets payed_value on payment creation' do
    consumption.payments << Payment.create(value: 5.99)
    consumption.payments << Payment.create(value: 7.99)
    consumption.save
    expect(consumption.payed_value).to eq 5.99 + 7.99
  end

  it 'automatically sets tip_value and discount_value when consumption state changed to payed (payment > total_price)' do
    consumption.products << drink_999
    consumption.payments << Payment.create(value: 5.99)
    consumption.payments << Payment.create(value: 7.99)
    consumption.save

    expect(consumption.payed_value).to eq 5.99 + 7.99
    consumption.update state: Consumption::PAYED

    expect(consumption.tip_value).to eq 5.99 + 7.99 - drink_999.price
    expect(consumption.discount_value).to eq 0
  end

  it 'automatically sets tip_value and discount_value when consumption state changed to payed (payment < total_price)' do
    consumption.products << drink_999
    consumption.products << drink_999
    consumption.payments << Payment.create(value: 5.99)
    consumption.payments << Payment.create(value: 7.99)
    consumption.save

    expect(consumption.payed_value).to eq 5.99 + 7.99
    consumption.update state: Consumption::PAYED

    expect(consumption.tip_value).to eq 0
    expect(consumption.discount_value).to eq drink_999.price * 2 - 5.99 - 7.99
  end
end
