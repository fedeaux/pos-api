class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.decimal :price, default: 0.0, precision: 10, scale: 2
      t.boolean :active, default: true
      t.belongs_to :category

      t.timestamps
    end
  end
end
