class Order < ApplicationRecord
  belongs_to :coupen, optional: true
  belongs_to :user
  has_many :cart_items

  enum status: {placed: 0 ,shipped: 1}

end
