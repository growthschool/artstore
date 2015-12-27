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

    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end
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
      get :pay_with_credit_card
      post :pay2go_cc_notify
      post :pay2go_atm_complete
    end
  end
    
  root "products#index"

  resources :carts do 
    collection do
      post :checkout
      delete :clean
    end
  end

  resources :items, controller: "cart_items"
end
