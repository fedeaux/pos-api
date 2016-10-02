class V1::RestaurantController < ApplicationController
  before_action :set_restaurant

  def show
  end

  def update
    @restaurant.update restaurant_params
    render :show
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def set_restaurant
    @restaurant = Restaurant.instance
  end
end
