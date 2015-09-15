class Cart < ActiveRecord::Base
	has_many :cart_items, dependent: :destroy # 一個購物車可以有好幾個 items
	has_many :items, through: :cart_items, source: :product # 透過 cart_items, 取得各自 cart_item 的 product 成為 items

	def add_product_to_cart(product)
		items << product
	end

	def total_price
		# 預設值為 0 開始計算
		items.inject(0) { |sum, item| sum + item.price }
	end
end
