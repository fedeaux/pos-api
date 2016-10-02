require 'rails_helper'

RSpec.describe "Waiters requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_waiters_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    describe "GET /v1/waiters" do
      it 'returns a list of waiters' do
        create :waiter_alfred
        create :waiter_robin
        create :waitress_amelia

        get v1_waiters_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response['waiters'].count).to eq 3
      end
    end

    describe "GET /v1/waiters/:id" do
      it 'returns the waiter info' do
        waiter = create :waitress_amelia

        get v1_waiter_path(waiter), headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'waiter'
      end
    end

    describe "POST /v1/waiters" do
      it 'creates a new waiter' do
        post v1_waiters_path, headers: @request_headers, params: { waiter: attributes_for(:waiter_alfred) }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'waiter'
      end
    end

    describe "PUT /v1/waiters" do
      it 'updates a waiter' do
        waiter = create :waitress_amelia

        put v1_waiter_path(waiter), headers: @request_headers, params: { waiter: { name: 'Jilian' } }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'waiter'
        expect(json_response['waiter']['name']).to eq 'Jilian'
      end
    end
  end
end
