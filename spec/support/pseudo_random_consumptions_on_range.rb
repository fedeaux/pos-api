module FactoryGirl
  module Syntax
    module Methods
      def create_pseudo_random_consumptions_on_range(start, finish, force_products: false, force_tables: false)
        if Product.count == 0
          if force_products
            create :product_food
            create :product_drink
          else
            raise "It doesn't make sense to create consumptions without products. Create some products before calling this method or call with force_products: true"
          end
        end

        if Table.count == 0
          if force_tables
            Table.ensure_amount 3
          else
            raise "It doesn't make sense to create consumptions without tables. Ensure some tables before calling this method or call with force_tables: true"
          end
        end

        current_time = start.utc.change({ hour: 12, min: 0, sec: 0 })
        final_time = finish.end_of_day.utc

        # Create a products array with different number of occurrences so consumptions
        # are not equally distributed

        # Using shuffle with a seeded generator leads to the same result everytime
        products = Product.order('name').all.each_with_index.map { |product, index|
          [product] * (index + 1)
        }.flatten.shuffle(random: Random.new(1))

        index = 0

        number_of_products = [2, 3, 4, 5]

        # Generate payments based on type of payment
        # Values greater than 1 represent payment with tip
        payed_values = [1.2, 1.1, 1.05, 1, 1, 0.9]

        # Intercalate between waiters and "no waiter"
        waiters = (Waiter.all.to_a * 2).flatten
        waiters.push nil

        # A general access index. It will be used to pseudo randomly create consumption data
        index = 0

        while current_time < final_time
          Table.all.each do |table|
            (1..3).each do |i|
              table.update state: Table::OCCUPIED
              consumption = table.active_consumption
              consumption.update created_at: (current_time + i.hours), waiter: waiters[ index % waiters.length ]

              # Products
              number_of_products[index % number_of_products.length].times do
                consumption.products << products[index % products.length]
                index += 1
              end

              consumption.save

              # Payments
              number_of_payments = ((index % 3) + 1)
              total_payed = consumption.total_price * payed_values[index % payed_values.length]
              value_per_payment = total_payed / number_of_payments

              number_of_payments.times do
                consumption.payments << Payment.create(value: value_per_payment, created_at: (current_time + (1 + i).hours))
              end

              consumption.update state: Consumption::PAYED
              table.update state: Table::AVAILABLE
              current_time += 1.hour
              index += 1
            end

            current_time = current_time.change({ hour: 12, min: 0, sec: 0 })
          end

          current_time += 2.day
        end
      end
    end
  end
end
