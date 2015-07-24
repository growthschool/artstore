Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :products
    resources :orders
   end
  
  namespace :account do
    resources :orders
  end
  
  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :orders do
    member do
      get 'pay_with_credit_card'
    end
  end



  resources :carts do
    collection do
      post 'checkout'
      delete 'clean'
    end
  resources :items, :controller => "cart_items"
  end

  
  root :to => 'products#index'

end
