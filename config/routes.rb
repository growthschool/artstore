Rails.application.routes.draw do
  
  devise_for :users
  
  namespace :admin do 
    resources :products
  end

  resources :products
    member do
      post :add_to_cart
    end
  end
    root :to => "products#index" 
    resources :carts
end
