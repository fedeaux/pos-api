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

  def create
    Table.ensure_amount Table.count + 1
    @table = Table.last
    render :show
  end

  private
  def table_params
    params.require(:table).permit(:state)
  end

  def set_table
    @table = Table.find params[:id]
  end
end
