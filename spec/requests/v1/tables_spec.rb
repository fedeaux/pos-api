require 'rails_helper'

RSpec.describe "Tables requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_tables_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    describe "GET /v1/tables" do
      it 'returns a list of tables' do
        Table.ensure_amount 5
        get v1_tables_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response['tables'].count).to eq 5
      end
    end
  end
end
