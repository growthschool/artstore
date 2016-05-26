class CartsController < ApplicationController
	before_action :authenticate_user!, only: [:checkout]
    #這邊是在開始結帳時強制檢查登入狀態 讓一般訪客也可以先進行把東西放到購物車
 def checkout
   @order = current_user.orders.build
   @info = @order.build_info
 end

 def clean
 	current_cart.clean!
 	flash[:warning] = "已清空購物車"
 	redirect_to carts_path
 end

end
