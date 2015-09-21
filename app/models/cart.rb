class Cart < ActiveRecord::Base
	has_many :cart_items, dependent: :destroy # 一個購物車可以有好幾個 items
	has_many :items, through: :cart_items, source: :product # 透過 cart_items, 取得各自 cart_item 的 product 成為 items

	def add_product_to_cart(product, quantity = 1)
		cart_item = self.cart_items.build
		cart_item.product = product
		cart_item.quantity = quantity
		cart_item.save
	end

	def total_price
		# 預設值為 0 開始計算
		cart_items.inject(0) { |sum, item| sum + item.total }
	end
end
