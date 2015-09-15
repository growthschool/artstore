class Cart < ActiveRecord::Base
	has_many :cart_items, dependent: :destroy # 一個購物車可以有好幾個 items
	has_many :items, through: :cart_items, source: :product
end
