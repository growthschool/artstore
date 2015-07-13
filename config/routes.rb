Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  
  resources :products

  namespace :admin do
    resources :products
  end

end
