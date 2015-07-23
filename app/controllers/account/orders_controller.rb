class Account::OrdersController < ApplicationController

  def index
    @orders = current_user.orders.recent # Model User has_many :orders
  end
end
