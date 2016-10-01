require 'factory_girl_rails'

after(:product_categories) do
  Waiter.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence!(Waiter.table_name)

  FactoryGirl.create :waiter_alfred
  FactoryGirl.create :waiter_robin
  FactoryGirl.create :waitress_amelia
end
