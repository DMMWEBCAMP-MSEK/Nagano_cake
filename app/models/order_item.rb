class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :amount, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  enum production_status: {
     not_startable: 0,
     waiting_for_production: 1,
     in_production: 2,
     production_completed: 3
  }

end
