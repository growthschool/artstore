Rails.application.routes.draw do

  root :to => "products#index"

  devise_for :users

  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  namespace :account do
    resources :orders
  end

  resources :products

  resources :products do
   member do
     post :add_to_cart
   end
  end

  resources :carts do
    collection do
      post 'checkout'
      delete 'clean'
    end
    resources :items, :controller => "cart_items"
  end

  resources :orders do
    member do
      get 'pay_with_credit_card'
    end
  end

  resources :orders
end
