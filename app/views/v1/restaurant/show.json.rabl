object :@restaurant
attributes :name, :initialized

node :errors do |restaurant|
  restaurant.errors.messages
end
