module Admin::OrdersHelper
	def render_order_options_for_admin(order)
		render :partial => "admin/orders/state_options", :locals => { :order => order}
	end
end
