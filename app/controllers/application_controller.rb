class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

   # 若要讓View 也能使用，就要加上helper_method的設定
  helper_method :current_cart

  # 如果 @current 不為空, 回傳@current_cart
  def current_cart
    @current_cart ||= find_cart  # 若這個值是空的話, 就去執行find_cart這個method
  end

  private

  def find_cart
    # 首先去找現在使用者的session有沒有cart_id這個值，這樣就可以找到現在這個使用者的購物車
    cart = Cart.find_by(id: session[:cart_id])

    # 如果找不到，就幫他創造一個購物車
    unless cart.present?
      cart = Cart.create
    end

    # 再重新設定 session[:card_id]的值
    session[:cart_id] = cart.id
    cart
  end
end
