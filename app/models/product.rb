class Product < ActiveRecord::Base
	has_one :photo

	accepts_nested_attributes_for :photo
end
		
		# schema for product model:
    # t.string   "title"
    # t.text     "description"
    # t.integer  "quantity"
    # t.integer  "price"
    # t.datetime "created_at",  null: false
    # t.datetime "updated_at",  null: false