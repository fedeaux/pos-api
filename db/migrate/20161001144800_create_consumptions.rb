class CreateConsumptions < ActiveRecord::Migration[5.0]
  def change
    create_table :consumptions do |t|
      t.string :state
      t.decimal :total_price, default: 0.0, precision: 10, scale: 2
      t.decimal :payed_value, default: 0.0, precision: 10, scale: 2
      t.decimal :discount_value, default: 0.0, precision: 10, scale: 2
      t.decimal :tip_value, default: 0.0, precision: 10, scale: 2
      t.belongs_to :table, foreign_key: true

      t.timestamps
    end
  end
end
