Rails.application.routes.draw do
  
  devise_for :users
  namespace :admin do
  	root 'products#index'
    resources :products
    resources :users do
    	post :to_admin
    	post :to_user
    end
  end
  resources :products
  root 'products#index'
end
