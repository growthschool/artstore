class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }
  validate :check_quantity

  private

  def check_quantity
    if quantity > product.quantity
      errors.add(:quantity, "should be less than #{product.quantity}")
    end
  end
end
