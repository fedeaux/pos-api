require 'rails_helper'

RSpec.describe "Product categories requests", type: :request do
  context "Unauthorized users" do
    it 'returns an error to unathorized users' do
      get v1_product_categories_path
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end

  context 'Authorized users' do
    before :each do
      set_request_headers_for :user_ray
    end

    describe "GET /v1/product_categories" do
      it 'returns a list of product categories' do
        create :category_drink
        create :category_food

        get v1_product_categories_path, headers: @request_headers
        json_response = JSON.parse(response.body)

        expect(json_response['product_categories'].count).to eq 2
      end
    end
  end
end
