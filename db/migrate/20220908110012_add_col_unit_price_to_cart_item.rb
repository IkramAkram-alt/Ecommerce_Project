class AddColUnitPriceToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :unit_price, :float
  end
end
