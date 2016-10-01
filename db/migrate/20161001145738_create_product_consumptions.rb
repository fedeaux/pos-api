class CreateProductConsumptions < ActiveRecord::Migration[5.0]
  def change
    create_table :product_consumptions do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :consumption, foreign_key: true

      t.timestamps
    end
  end
end
