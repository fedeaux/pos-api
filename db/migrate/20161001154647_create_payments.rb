class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :consumption, foreign_key: true
      t.decimal :value, default: 0.0, precision: 10, scale: 2
      t.string :observations

      t.timestamps
    end
  end
end
