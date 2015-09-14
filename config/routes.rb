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
    post "checkout", on: :collection
  end
  root 'products#index'
end
