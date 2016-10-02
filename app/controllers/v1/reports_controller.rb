class V1::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update]

  def index
    @reports = Report.all
    @available_period = {
      earliest: Consumption.minimum(:created_at),
      latest: Consumption.maximum(:created_at)
    }
  end

  def show
  end

  def update
    @report.update report_params
    render :show
  end

  def create
    @report = Report.create report_params
    render :show
  end

  private
  def report_params
    params.require(:report).permit(:start, :finish, reporters: [])
  end

  def set_report
    @report = Report.find params[:id]
  end
end
