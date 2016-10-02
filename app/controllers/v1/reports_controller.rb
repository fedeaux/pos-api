class V1::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :download_as_pdf]

  def index
    @reports = Report.all
    @available_period = {
      earliest: Consumption.minimum(:created_at),
      latest: Consumption.maximum(:created_at)
    }

    # This smells, I could've made a registration system, but so little time :(
    @available_reporters = ['Sales', 'Products', 'TipPerWaiter']
  end

  def show
    @results = @report.apply
  end

  def update
    @report.update report_params
    render :show
  end

  def create
    @report = Report.create report_params
    render :show
  end

  def download_as_pdf
    @results = @report.apply
    pdf = WickedPdf.new.pdf_from_string(render_to_string 'v1/reports/as_pdf.html.haml' )
    send_data pdf, type: "application/pdf", filename: 'report.pdf'
  end

  private
  def report_params
    params.require(:report).permit(:start, :finish, reporters: [])
  end

  def set_report
    @report = Report.find params[:id]
  end
end
