FactoryGirl.define do
  factory :report do
    start 1.week.ago
    finish 1.day.ago
    reporters ['Sales', 'TipPerWaiter', 'Products' ]
  end
end
