class Photo < ActiveRecord::Base
  belongs_to :product, dependent: :destroy

  mount_uploader :image, ImageUploader
end
