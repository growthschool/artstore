class Order < ActiveRecord::Base
	belongs_to :user

	has_many :items, class_name: "OrderItem", dependent: :destroy
	has_one :info, class_name: "OrderInfo", dependent: :destroy

	# 有這行才可以用巢狀表單
	accepts_nested_attributes_for :info

	# 在資料建立前都跑 generater_token 這個 method
	before_create :generate_token

	def generate_token
		self.token = SecureRandom.hex(7)
	end

	# 暫存交易紀錄
	def build_item_cache_from_cart(cart)
		cart.cart_items.each do |cart_item|
			item = items.build
			item.product_name = cart_item.product.title
			item.price = cart_item.product.price
			item.quantity = cart_item.quantity 
			item.save
		end
	end

	# 把總額存在 total 欄位上
	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end

	# 設定付款方式
	def set_payment_with!(method)
		self.update_column(:payment_method, method)
	end

	# 改變狀態為已經付款
	def pay!
		self.update_column(:is_paid, true)
	end

	# 取得付款狀態
	def paid?
		self.is_paid
	end

	# AASM 狀態機設定
	
	include AASM

	aasm column: :status do
		# states 依序是：已下訂單、已付款、出貨中、已出貨、取消訂單、退貨
		state :order_placed, initial: true
		state :paid
		state :shipping
		state :shipped
		state :order_cancelled
		state :good_returned

		# 付款 這個行為會讓狀態從 已下訂單 轉成 已付款
		event :make_payment, after_commit: :pay! do
			transitions from: :order_placed, to: :paid
		end

		# 出貨 這個行為會讓狀態從 已付款 轉成 出貨中
		event :ship do 
			transitions from: :paid, to: :shipping
		end

		# 送貨 這個行為會讓狀態從 出貨中 轉為 已出貨
		event :deliver do
			transitions from: :shipping, to: :shipped
		end

		# 退貨 這個行為會讓狀態從 已出貨 轉為 退貨
		event :return_good do
			transitions from: :shipped, to: :good_returned
		end

		# 取消訂單 這個行為會讓狀態從 [已下訂單, 已付款] 轉為 取消訂單
		event :cancel_order do
			transitions from: [:order_placed, :paid], to: :order_cancelled
		end
	end
end
