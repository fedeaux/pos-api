Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'v1' do
    get 'restaurant' => 'restaurant#show'
    put 'restaurant' => 'restaurant#update'
    get 'product_categories' => 'product_categories#index'

    resources :products
    resources :waiters
    resources :tables do
      get 'consumption' => 'table_consumption#index'
      put 'consumption/add_product' => 'table_consumption#add_product'
      put 'consumption/remove_product' => 'table_consumption#remove_product'
      put 'consumption/add_payment' => 'table_consumption#add_payment'
      put 'consumption/remove_payment' => 'table_consumption#remove_payment'
    end
  end
end
