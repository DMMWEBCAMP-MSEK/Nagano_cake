class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum production_status: {
     not_startable: 0,
     waiting_for_production: 1,
     in_production: 2,
     production_completed: 3
  }

  validates :item_id, :order_id, :amount, :price, presence: true
  validates :price, :amount, numericality: { only_integer: true }

  def subtotal
    amount*price
  end

end