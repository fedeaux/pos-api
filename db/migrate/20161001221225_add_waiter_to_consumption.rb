class AddWaiterToConsumption < ActiveRecord::Migration[5.0]
  def change
    add_reference :consumptions, :waiter, foreign_key: true
  end
end
