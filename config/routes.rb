Rails.application.routes.draw do
  root "products#index"
  resources :products
  
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
  
  
end
