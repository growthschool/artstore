class Order < ActiveRecord::Base
	belongs_to :user

	has_many :items , class_name: "OrderItem", dependent: :destroy
	has_one  :info , class_name: "OrderInfo", dependent: :destroy	

	accepts_nested_attributes_for :info

	def build_item_cache_form_cart(cart)
		cart.items.each do |cache_item|
			item = items.build
			item.product_name = cache_item.title
			item.price = cache_item.price
			item_product = cart.find_cart_item(cache_item)
			item.quantity = item_product.quantity
			item.save
			item_product.reduce_max_quantity_when_ordered(item.quantity)
		end 
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save 
	end

	include Tokenable

	def set_payment_with!(method)
		self.update_columns(payment_method: method)
	end

	def pay!
		self.update_columns(is_paid: true)
	end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end
end
