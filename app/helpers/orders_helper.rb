module OrdersHelper
	def render_order_status(order)
		t("orders.order_status.#{order.status}")
	end
end
