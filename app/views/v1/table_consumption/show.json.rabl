object :@table_consumption => :consumption

child(:products) do
  attributes :id, :name, :price, :code, :active
end

child(:payments) do
  attributes :id, :value, :observations
end
