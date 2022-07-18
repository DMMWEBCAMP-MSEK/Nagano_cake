class Item < ApplicationRecord

has_many :cart_items
has_many :order_items

def taxin_price
  price*1.0
end

end

