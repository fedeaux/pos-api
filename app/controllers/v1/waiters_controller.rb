class V1::WaitersController < ApplicationController
  before_action :set_waiter, only: [:show, :update]

  def index
    @waiters = Waiter.all
  end

  def show
  end

  def update
    @waiter.update waiter_params
    render :show
  end

  def create
    @waiter = Waiter.create waiter_params
    render :show
  end

  private
  def waiter_params
    params.require(:waiter).permit(:name)
  end

  def set_waiter
    @waiter = Waiter.find params[:id]
  end
end
