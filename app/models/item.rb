class Item < ApplicationRecord

<<<<<<< HEAD
has_many :cart_items
has_many :order_items

def taxin_price
  price*1.0
end
=======
  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image
>>>>>>> 6d23fb2109d59e768549ab52a2249ad939bc6b32

end

