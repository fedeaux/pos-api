FactoryGirl.define do
  factory :waiter_alfred, class: :waiter do
    name 'Alfred'
  end

  factory :waiter_robin, class: :waiter do
    name 'Robin'
  end

  factory :waitress_amelia, class: :waiter do
    name 'Amelia'
  end
end
