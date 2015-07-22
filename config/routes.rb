Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
  end

  resources :products do 
    member do 
      post :add_to_cart #ProductsController裡定義add_to_cart method
    end
  end
  #把某一個產品加入購物車
  #add_to_cart_product POST   /products/:id/add_to_cart(.:format) products#add_to_cart
    
  resources :carts do
    collection do
      post 'checkout'
    end
  end
  #不須限定某一個
  #checkout_carts POST   /carts/checkout(.:format)           carts#checkout


  resources :orders do
    member do
      get 'pay_with_credit_card'
    end
  end
  
  root 'products#index'
  





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
