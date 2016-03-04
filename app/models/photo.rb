class Photo < ActiveRecord::Base
  belongs_to :product

  mount_uploader :image, ImageUploader #裝上 ImageUploader這個上傳器到:image這個欄位
end
