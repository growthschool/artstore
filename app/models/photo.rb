class Photo < ActiveRecord::Base
  #這裡兩個分別為什麼意思
  belongs_to :product

  mount_uploader :image, ImageUploader

end
