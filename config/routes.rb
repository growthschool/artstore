Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end
  end
  resources :products do
    member do
      post :add_to_cart
    end
  end
  resources :orders
  root "products#index"
  resources :carts do
    collection do
      post :checkout
    end
  end
end
