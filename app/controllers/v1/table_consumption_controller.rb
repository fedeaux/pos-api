class V1::TableConsumptionController < ApplicationController
  before_action :set_table_and_consumption

  def index
    if @table_consumption
      render :show
    else
      head 404
    end
  end

  def show
  end

  def update
    @table_consumption.update table_consumption_params
    render :show
  end

  def create
    @table_consumption = TableConsumption.create table_consumption_params
    render :show
  end

  def add_product
    if @table_consumption
      set_product
      @table_consumption.products << @product
      render :show
    else
      head 422
    end
  end

  def remove_product
    if @table_consumption
      set_product
      @table_consumption.remove_one_product @product
      render :show
    else
      head 422
    end
  end

  private
  def set_table_and_consumption
    @table = Table.find params[:table_id]
    @table_consumption = @table.active_consumption
  end

  def set_product
    @product = Product.find params[:consumption][:product_id]
  end
end
