Rails.application.routes.draw do
  devise_for :users
  namespace :admin do 
    resources :products
    resources :orders
  end

  resources :products do
  	member do
  		post :add_to_cart
      post :delete_from_cart
  	end
  end

  resources :carts do
    collection do
      post 'checkout'
      delete 'clean'
    end

    resources :items, controller: "cart_items"
  end

  resources :orders do 
    member do
      get :pay_with_credit_card
    end
  end

  namespace :account do
    resources :orders
  end

  root 'products#index'
  
end
