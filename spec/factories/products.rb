FactoryGirl.define do
  factory :product_drink, class: :product do
    sequence(:name) {|n| "Drink #{n}" }
    sequence(:code) {|n| "drink-#{n}" }
    price 4.99
    category { create_or_find_product_category :category_drink }
  end

  factory :product_food, class: :product do
    sequence(:name) {|n| "Food #{n}" }
    sequence(:code) {|n| "food-#{n}" }
    price 7.99
    category { create_or_find_product_category :category_food }
  end
end
