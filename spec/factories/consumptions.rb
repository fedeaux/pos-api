FactoryGirl.define do
  factory :consumption do
    table { get_table }
    state Consumption::PAYED
  end
end
