Rails.application.routes.draw do

  root 'products#index'

  devise_for :users

  resources :orders do
    member do
      get 'pay_with_credit_card'
    end
  end

  resources :carts do
    collection do
      post 'checkout'
    end
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  namespace :admin do
    resources :products
  end

end
