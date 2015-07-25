class Account::OrdersController < ApplicationController

  before_action :authenticate_user!

  def index #顧客本人可以在後台看到自己的訂單
    @orders = current_user.orders.recent
  end

end
