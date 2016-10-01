require 'rails_helper'

RSpec.describe "Table consumption requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_table_consumption_path(1)
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    let(:table) {
      Table.ensure_amount 1
      Table.first
    }

    let(:product_1) { create :product_food }
    let(:product_2) { create :product_food }

    describe "GET /v1/tables/:table_id/consumption" do
      it 'returns the tables underlying consumption' do
        get v1_table_consumption_path(table), headers: @request_headers
        expect(response).to have_http_status 404

        table.update state: Table::OCCUPIED

        get v1_table_consumption_path(table), headers: @request_headers
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'consumption'
        expect(json_response['consumption']).to have_key 'products'
        expect(json_response['consumption']).to have_key 'payments'
      end
    end

    describe "PUT /v1/tables/:table_id/consumption" do
      it 'adds a product to the table consumption and returns the consumption info' do
        table.update state: Table::OCCUPIED

        put v1_table_consumption_add_product_path(table), headers: @request_headers,
          params: {
            consumption: {
              product_id: product_1.id
            }
          }

        expect(table.active_consumption.products).to include product_1
        expect(JSON.parse(response.body)).to have_key 'consumption'
      end
    end
  end
end
