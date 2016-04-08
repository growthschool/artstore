class Photo < ActiveRecord::Base
  belongs_to :product   #為什麼放在這個model下？
  mount_uploader :image, ImageUploader #怎麼知道要下這個指令？
end
