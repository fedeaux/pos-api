object :@table_consumption => :consumption
attributes :id, :total_price, :payed_value, :state

child(:products) do
  attributes :id, :name, :price, :code, :active
end

child(:payments) do
  attributes :id, :value, :observations
end
