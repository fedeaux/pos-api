module Reporters
  class Products < Base
    def initialize
      @product_count = {}
    end

    def include(consumption)
      consumption.products.each do |product|
        if @product_count[product.id]
          @product_count[product.id][:amount] += 1
        else
          @product_count[product.id] = {
            amount: 1,
            product: {
              name: product.name
            }
          }
        end
      end
    end

    def finish
      @total_sales = @product_count.values.inject(0) { |sum, product_count|
        sum + product_count[:amount]
      }

      @popular_products = @product_count.values.sort { |product_count_1, product_count_2|
        product_count_2[:amount] <=> product_count_1[:amount]
      }.first(5).reject(&:nil?)
    end
  end
end
