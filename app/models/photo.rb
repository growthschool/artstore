class Photo < ActiveRecord::Base
	belongs_to :product

	mount_uploader :image, ImageUploader

end

    #t.integer  "product_id"
    #t.string   "image"
    #t.datetime "created_at", null: false
    #t.datetime "updated_at", null: false
