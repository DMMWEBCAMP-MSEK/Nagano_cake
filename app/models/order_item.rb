class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum payment_method:{ credit_card: 0, transfer: 1 }

end
