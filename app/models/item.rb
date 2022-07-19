class Item < ApplicationRecord

  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image

  has_many :cart_items
  has_many :order_items

def with_tax_price
    (price * 1.1).floor
end

end

