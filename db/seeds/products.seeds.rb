require 'factory_girl_rails'

after(:product_categories) do
  Product.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence!(Product.table_name)

  drink_category = ProductCategory.where(name: 'Drink').first
  food_category = ProductCategory.where(name: 'Food').first

  10.times do |i|
    FactoryGirl.create :product_drink, category: drink_category
    FactoryGirl.create :product_food, category: food_category
  end
end
