require 'rails_helper'

RSpec.describe 'Table and Consumption interaction', type: :model do
  let(:table) {
    Table.ensure_amount 1
    Table.first
  }

  it 'Automatically creates an open consumption when the table state changes to "occupied"' do
    expect(table.state).to eq Table::AVAILABLE

    table.update state: Table::OCCUPIED

    expect(table.consumptions.count).to eq 1
    expect(table.active_consumption).to be_kind_of Consumption
    expect(table.active_consumption.state).to eq Consumption::OPEN
  end

  it 'Destroys a consumption with no products if the table state changes to "available"' do
    table.update state: Table::OCCUPIED
    table.update state: Table::AVAILABLE

    expect(table.active_consumption).to be nil
    expect(Consumption.count).to eq 0
  end

  it 'Prohibits a table state from being set to "available" if its active_consumption has products and its state is "open"' do
    # Occupy table
    table.update state: Table::OCCUPIED

    # Add some consumption
    table.active_consumption.update products: create_list(:product_food, 3)

    # Try to release the table
    table.update state: Table::AVAILABLE

    # Can't do it
    expect(table).to be_invalid
    expect(table.errors[:state]).not_to be_empty

    table.reload
    expect(table.state).to eq Table::OCCUPIED
  end

  it 'Allows a table state to be set to "available" if its active_consumption is "payed"' do
    # Occupy table
    table.update state: Table::OCCUPIED

    # Add some consumption
    table.active_consumption.update products: create_list(:product_food, 3)

    # Set consumption to payed
    previous_consumption = table.active_consumption
    previous_consumption.update state: Consumption::PAYED
    expect(table.active_consumption).to be nil
    expect(table.consumption_ids).to include previous_consumption.id

    # Try to release the table
    table.update state: Table::AVAILABLE

    table.reload
    expect(table.state).to eq Table::AVAILABLE
  end

  it 'Allows a table state to be set to "available" if its active_consumption is "canceled"' do
    # Occupy table
    table.update state: Table::OCCUPIED

    # Add some consumption
    table.active_consumption.update products: create_list(:product_food, 3)

    # Set consumption to payed
    table.active_consumption.update state: Consumption::CANCELED

    # Try to release the table
    table.update state: Table::AVAILABLE

    table.reload
    expect(table.state).to eq Table::AVAILABLE
  end
end
