require 'rails_helper'

RSpec.describe "Exercises", type: :request do
  describe "GET /v1/restaurant" do
    it 'returns an error to unathorized users' do
      get v1_restaurant_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end

    context 'Authorized users' do
      before :each do
        set_request_headers_for :user_ray
      end

      it 'returns the restaurant info' do
        get v1_restaurant_path, headers: @request_headers
        expect(JSON.parse(response.body)).to have_key 'restaurant'
      end
    end
  end
end
