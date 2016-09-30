FactoryGirl.define do
  factory :category_drink, class: :product_category do
    name 'Drink'
  end

  factory :category_food, class: :product_category do
    name 'Food'
  end
end
