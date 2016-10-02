attributes :id, :name, :price, :code, :active

child(:category) do
  attributes :id, :name
end
