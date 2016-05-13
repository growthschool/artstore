class Photo < ActiveRecord::Base
  belongs_to :product

  mount_uploader :photo, ImageUploader
end
