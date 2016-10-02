require 'rails_helper'

RSpec.describe "Reports requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_reports_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
      create_pseudo_random_consumptions_on_range 2.days.ago, 1.day.ago, force_products: true, force_tables: true
    end

    describe "GET /v1/reports" do
      it 'returns a list of reports' do
        report = create :report
        report = create :report

        get v1_reports_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response['reports'].count).to eq 2
        expect(json_response['available_period']).to have_key 'earliest'
        expect(json_response['available_period']).to have_key 'latest'
        expect(json_response['available_reporters'].sort).to eq ['Products', 'Sales', 'TipPerWaiter']
      end
    end

    describe "GET /v1/reports/:id" do
      it 'returns the report info' do
        report = create :report

        get v1_report_path(report), headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'report'
      end
    end

    describe "POST /v1/reports" do
      it 'creates a new report' do
        expect {
          post v1_reports_path, headers: @request_headers, params: { report: attributes_for(:report) }
        }.to change{Report.count}.by(1)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'report'
      end
    end

    describe "PUT /v1/reports" do
      it 'updates a report' do
        report = create :report
        previous_start = report.start

        put v1_report_path(report), headers: @request_headers, params: { report: { start: previous_start - 1.week } }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'report'

        report.reload
        expect(report.start < previous_start).to be true
      end
    end
  end
end
