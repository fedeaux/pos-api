require 'factory_girl_rails'
require_relative '../../spec/support/pseudo_random_consumptions_on_range'

after(:products, :tables) do
  # This seed generates around 1000 consumptions
  FactoryGirl.create_pseudo_random_consumptions_on_range(2.months.ago, 1.hour.ago)
end
