class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_users.orders.order("id DESC")
end
