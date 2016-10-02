module Reporters
  class TipPerWaiter < Base
    def initialize
      @tip_per_waiter = {}
    end

    def include(consumption)
      if @tip_per_waiter[consumption.waiter_id]
        @tip_per_waiter[consumption.waiter_id] += consumption.tip_value
      else
        @tip_per_waiter[consumption.waiter_id] = 0
      end
    end
  end
end
