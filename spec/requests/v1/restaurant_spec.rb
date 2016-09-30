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
        expect(json_response['restaurant']['initialized']).to eq false
      end
    end

    describe "POST /v1/restaurant" do
      it 'updates the restaurant and returns its info if given valid data' do
        post v1_restaurant_path, headers: @request_headers, params: { restaurant: { name: "Adrian's" }}

        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'restaurant'
        expect(json_response['restaurant']['name']).to eq "Adrian's"
        expect(json_response['restaurant']['initialized']).to eq true
        expect(json_response['restaurant']['errors']).to be_empty
      end

      it 'rejects the update returns its previous info with error messages if given invalid' do
        post v1_restaurant_path, headers: @request_headers, params: { restaurant: { name: nil }}

        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'restaurant'
        expect(json_response['restaurant']['name']).to eq nil
        expect(json_response['restaurant']['initialized']).to eq false
        expect(json_response['restaurant']['errors']).not_to be_empty
      end

    end
  end
end
