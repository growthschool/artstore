Rails.application.routes.draw do
	root to: "products#index"
	devise_for :users, :controllers => { :registrations => "users/registrations" }

	namespace :admin do
		resources :products
		resources :orders, only: [:index, :show] do
			member do
				post :cancel
				post :ship
				post :shipped
				post :return
			end
		end
	end

	resources :products, only: [:index, :show] do
		member do
			# 指定 post 的路徑給「加入購物車使用」
			post :add_to_cart
		end
	end

	resources :carts, only: [:index] do
		collection do # 用 collection 的時候， path 中不用傳類似 :id 這種參數
			post "checkout"
			delete "clean"
		end
	end

	resources :orders, only: [:index, :show, :create] do
		member do
			get :pay_with_credit_card
		end
	end
	
	resources :items, only: [:update, :destroy], controller: "cart_items"

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
