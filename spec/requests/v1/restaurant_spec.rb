require 'rails_helper'

RSpec.describe "Exercises", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_restaurant_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    describe "GET /v1/restaurant" do
      it 'returns the restaurant info' do
        get v1_restaurant_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'restaurant'
        expect(json_response['restaurant']['name']).to eq nil
      end
    end

    describe "POST /v1/restaurant" do
      it 'updates the restaurant and returns its info' do
        post v1_restaurant_path, headers: @request_headers, params: { restaurant: { name: "Adrian's" }}

        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'restaurant'
        expect(json_response['restaurant']['name']).to eq "Adrian's"
      end
    end
  end
end
