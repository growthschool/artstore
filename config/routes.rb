Rails.application.routes.draw do
  resources :carts do
    collection do
      post 'checkout'
      delete 'clean'
    end

    resources :items, :controller => "cart_items"

  end

  namespace :account do 
    resources :orders
  end

  resources :orders do
    member do
      get 'pay_with_credit_card'
    end
  end

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

  resources :products do
    member do
      post :add_to_cart
    end
  end

  root :to => "products#index"
end
