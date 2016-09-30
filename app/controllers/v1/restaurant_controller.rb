class V1::RestaurantController < ApplicationController
  def show
    @restaurant = Restaurant.instance
  end
end
