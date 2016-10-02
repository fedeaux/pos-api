require 'factory_girl_rails'

after(:base) do
  FactoryGirl.create :waiter_alfred
  FactoryGirl.create :waiter_robin
  FactoryGirl.create :waitress_amelia
end
