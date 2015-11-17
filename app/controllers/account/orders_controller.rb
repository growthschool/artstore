class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC") # .order("id DESC")  訂單依照最新-最舊順序排列
  end
end
