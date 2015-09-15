class AddProductIdToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :product, index: true, foreign_key: true
  end
end
