after(:base) do
  ProductCategory.where(name: 'Drink').first_or_create
  ProductCategory.where(name: 'Food').first_or_create
end
