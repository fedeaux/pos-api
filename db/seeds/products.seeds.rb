require 'factory_girl_rails'

after(:product_categories) do
  drink_category = ProductCategory.where(name: 'Drink').first
  food_category = ProductCategory.where(name: 'Food').first

  [['Coffee', 7.90], ['Tea', 8.90], ['Beer', 4.90], ['Coke', 3.90], ['Sprite', 3.90]].each do |pair|
    FactoryGirl.create :product_drink, category: drink_category, name: pair[0], price: pair[1]
  end

  [['Chips', 1.90], ['Burguer', 2.90], ['Fish', 14.90], ['Steak', 13.90], ['Chicken', 12.90], ['Pasta', 8.90]].each do |pair|
    FactoryGirl.create :product_food, category: food_category, name: pair[0], price: pair[1]
  end
end
