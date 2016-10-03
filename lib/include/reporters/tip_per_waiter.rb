module Reporters
  class TipPerWaiter < Base
    attr_reader :tip_per_waiter

    def initialize
      @tip_per_waiter = { unassigned: { value: 0, waiter: { name: 'Unassigned to anyone' }}}
    end

    def include(consumption)
      key = consumption.waiter_id ? consumption.waiter_id : :unassigned

      if @tip_per_waiter[key]
        @tip_per_waiter[key][:value] += consumption.tip_value
      else
        @tip_per_waiter[key] = {
          value: consumption.tip_value,
          waiter: {
            name: consumption.waiter.name
          }
        }
      end
    end
  end
end
