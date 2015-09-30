class Product < ActiveRecord::Base
  has_many :photos
  accepts_nested_attributes_for :photos

  validates :quantity, numericality: { greater_than: 0 }

  def default_image
    photos.last.image unless photos.last.nil?
  end
end
