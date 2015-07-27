Rails.application.routes.draw do
  
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

  resources :carts do
    collection do
      post 'checkout'
    end

		resources :item, :controller => "cart_items"
  end

  resources :orders do
    get 'pay_with_credit_card'
  end

  namespace :account do
    resources :orders
  end
  
  root :to => "products#index"
end
