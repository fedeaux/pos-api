class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :reporters
      t.date :start
      t.date :finish

      t.timestamps
    end
  end
end
