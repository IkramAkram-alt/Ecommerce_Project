class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, class_name: "order", foreign_key: "order_id",optional: true
  before_create :set_unit_price

  def set_unit_price
    self.unit_price = product.price
  end

  def subtotal(item)
    item.quantity * item.product.price
  end

  def total(cart_items)
    cart_items.to_a.sum{|item| subtotal(item)}
  end
end
