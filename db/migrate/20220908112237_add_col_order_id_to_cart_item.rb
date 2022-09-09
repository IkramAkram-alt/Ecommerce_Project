class AddColOrderIdToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :cart_items, :order, null: true, foreign_key: true
  end
end
