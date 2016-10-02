module Reporters
  class Sales < Base
    def initialize
      @sold_products_total_value = 0
      @total_income = 0
      @total_in_tips = 0
      @house_income = 0
      @discounts = 0
    end

    def include(consumption)
      @sold_products_total_value += consumption.total_price
      @total_income += consumption.payed_value
      @house_income += (consumption.payed_value - consumption.tip_value)
      @discounts += consumption.discount_value
      @total_in_tips += consumption.tip_value
    end
  end
end
