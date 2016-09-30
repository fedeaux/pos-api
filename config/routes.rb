Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'v1' do
    get 'restaurant' => 'restaurant#show'
    put 'restaurant' => 'restaurant#update'
    get 'product_categories' => 'product_categories#index'
    resources :tables
    resources :products
  end
end
