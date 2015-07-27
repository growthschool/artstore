Rails.application.routes.draw do

  root 'products#index'

  devise_for :users

  resources :orders do
    member do
      get 'pay_with_credit_card'
      post :allpay_notify
    end
  end

  resources :carts do
    collection do
      post 'checkout'
      delete 'clean'
    end

    resources :items, controller: "cart_items"
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

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

end
