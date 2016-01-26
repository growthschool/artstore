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
  resources :products
  root "products#index"
end
