class Admin::OrdersController < ApplicationController
    layout "admin"

    before_action :autherticate_user!
    before_action :admin_required

    def index
        @orders = Order.order("id DESC")
    end
end
