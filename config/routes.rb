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

  namespace :account do
    resources :orders
  end

  resources :products do
    member do                      #新增成員路由
      post :add_to_cart            #add_to_cart_product POST   /products/:id/add_to_cart(.:format)
    end
  end
  resources :carts do
    post "checkout", on: :collection  #新增一筆集合路由  on:collection 和成員路由相同 checkout_carts  /carts/checkout(.format)
    delete "clean", on: :collection

    resources :items, :controller => "cart_items" #識別出以 /items 開頭的請求，交給 cart_items Controller 處理
  end



  resources :orders do
    member do
      get :pay_with_credit_card
    end
  end

  root "products#index"
end
