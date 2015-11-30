class CartItemsController < ApplicationController

def destroy
  @cart = current_cart
  @item = @cart.cart_items.find_by(product_id: params[:id])
  @product = @item.product
  @item.destroy

  flash[:warning] = "成功將#{@product.title} 從購物車刪除！"
  redirect_to :back
end

def update
  @cart = current_cart
  @item = @cart.find_cart_item(params[:id])  # 在cart.rb定義helper find_cart_item(product)以簡化常用程式碼

  if @item.product.quantity >= item_params[:quantity].to_i  # 在頁面選擇數量時form_for f.select存入的是string, 這裏用to_i比較保險
  @item.update(item_params)
  flash[:notice] = "成功變更數量"
  else
    flash[:warning] = "數量不足以加入購物車"
  end

  redirect_to carts_path
end

private

def item_params
  params.require(:cart_item).permit(:quantity)
end


end
