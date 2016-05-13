class Product < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
end
