module Reporters
  class Sales < Base
    def initialize
      @sales_total_value = 0
      @total_income = 0
      @house_income = 0
      @discounts = 0
    end

    def include(consumption)
      @sales_total_value += consumption.total_price
      @total_income += consumption.payed_value
      @house_income += (consumption.payed_value - consumption.tip_value)
      @discounts += consumption.discount_value
    end
  end
end
