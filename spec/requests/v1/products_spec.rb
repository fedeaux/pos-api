require 'rails_helper'

RSpec.describe "Products requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_products_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    describe "GET /v1/products" do
      it 'returns a list of active products' do
        create_list :product_drink, 5

        get v1_products_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response['products'].count).to eq 5
      end
    end

    describe "GET /v1/products/:id" do
      it 'returns the product info' do
        product = create :product_food

        get v1_product_path(product), headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key 'product'
      end
    end

    describe "POST /v1/products" do
      it 'creates a new product' do
        post v1_products_path, headers: @request_headers, params: { product: attributes_for(:product_food) }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'product'
      end
    end

    describe "PUT /v1/products" do
      it 'updates a product' do
        product = create :product_food

        put v1_product_path(product), headers: @request_headers, params: { product: { name: 'Food 2000' } }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key 'product'
        expect(json_response['product']['name']).to eq 'Food 2000'
      end
    end
  end
end
