class Order < ActiveRecord::Base
	belongs_to :user

	has_many :items, class_name: "OrderItem", dependent: :destroy
	has_one :info, class_name: "OrderInfo", dependent: :destroy

	accepts_nested_attributes_for :info

	before_create :generate_token

	def generate_token
		self.token = SecureRandom.uuid
	end

	def build_item_cache_from_cart(cart)
		cart.items.each do |cart_item|
			item = items.build
			item.product_name = cart_item.title
			item.quantity= 1
			item.price = cart_item.price
			item.save
		end
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end

	def set_payment_with!(method)
		self.update_columns(payment_method: method)
	end

	def pay!
		self.update_columns(is_paid: true)
	end
end