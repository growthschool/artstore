class Account::OrdersController < ApplicationController

  def index
    @orders = current_user.orders.order("id DESC") # Model User has_many :orders
  end
end
