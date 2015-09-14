# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

	process resize_to_fill: [800, 800]

  version :medium do
    process :resize_to_fill => [400, 400]
  end

  version :small do
    process :resize_to_fill => [200, 200]
  end
end
