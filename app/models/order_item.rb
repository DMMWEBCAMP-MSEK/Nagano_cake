class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum payment_method:{ credit_card: 0, transfer: 1 }
  enum production_status: { not_yet: 0, waiting_production: 1, in_production: 2, complete_production: 3 }

  validates :item_id, :order_id, :amount, :price, presence: true
  validates :price, :quantity, numericality: { only_integer: true }

end
