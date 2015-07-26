Rails.application.routes.draw do
  
  devise_for :users
  
  namespace :admin do 
    resources :products
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      post 'checkout'
    end

		resources :item, :controller => "cart_items"
  end

  resources :orders
  
  root :to => "products#index"
end
