class Photo < ActiveRecord::Base
  belongs_to :product

  mount_uploader :image, ImageUploader
  # 這句話是什麼意思
end
