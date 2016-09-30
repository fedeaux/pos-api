class AddInitializedToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :initialized, :boolean, default: false
  end
end
