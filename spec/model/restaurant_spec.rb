require 'rails_helper'

RSpec.describe Restaurant do
  it 'is a singleton' do
    expect{ Restaurant.create }.to raise_error NoMethodError
    expect( Restaurant.instance ).to be_kind_of Restaurant
  end

  it 'starts with the initialize flag set to false' do
    expect( Restaurant.instance.initialized ).to eq false
  end

  it 'sets the initialize flag to true after saved with valid data for the first time' do
    restaurant = Restaurant.instance
    restaurant.update name: 'Pizza Hut'

    expect( restaurant.initialized ).to eq true
  end

  it 'keeps the initialize flag as false if save fails' do
    restaurant = Restaurant.instance
    restaurant.update name: ''

    expect( restaurant.initialized ).to eq false
  end
end
