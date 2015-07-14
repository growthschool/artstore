Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    resources :products
  end

  resources :products

  root :to => "products#index"
end
