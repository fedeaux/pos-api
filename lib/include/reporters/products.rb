module Reporters
  class Products < Base
    def initialize
      @product_count = {}
    end

    def include(consumption)
      consumption.products.each do |product|
        if @product_count[product.id]
          @product_count[product.id] += 1
        else
          @product_count[product.id] = 0
        end
      end
    end
  end
end
