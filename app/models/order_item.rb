class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :item_id, :order_id, :amount, :price, presence: true
  validates :price, :quantity, numericality: { only_integer: true }

end
