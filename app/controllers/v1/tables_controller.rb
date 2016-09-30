class V1::TablesController < ApplicationController
  before_action :set_table, only: [:show, :update]

  def index
    @tables = Table.all
  end

  def show
  end

  def update
    @table.update table_params
    render :show
  end

  private
  def table_params
    params.require(:table).permit(:name)
  end

  def set_table
    @table = Table.find params[:id]
  end
end
