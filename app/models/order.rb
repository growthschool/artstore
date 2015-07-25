class Order < ActiveRecord::Base

	belongs_to :user
	has_many :items, :class_name => "OrderItem", :dependent => :destroy
	has_one :info, class_name: "OrderInfo", dependent: :destroy

	accepts_nested_attributes_for :info
	

	def build_item_cache_from_cart(cart)
    	cart.items.each do |cart_item|
    		item = items.build
    		item.product_name = cart_item.product.title
    		item.quantity = cart_item.quantity
    		item.price = cart_item.product.price
    		item.save
    	end
	end

	def calculate_total!(cart)
	self.total = cart.total_price
	self.save
	end

	before_create :generate_token
 
	def generate_token
    	self.token = SecureRandom.uuid
	end

	def paid?
    	is_paid
	end

	def set_payment_with!(method)
		self.update_column(:payment_method, method)
	end

	def pay!
    	self.update_column(:is_paid, true )
	end

	include AASM
 
  aasm do
    state :order_placed, initial: true
    state :paid, after_commit: :pay!
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned
 
 
    event :make_payment do
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
