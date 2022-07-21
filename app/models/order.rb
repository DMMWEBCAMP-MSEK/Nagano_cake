class Order < ApplicationRecord

  has_many :order_items

  belongs_to :customer

  validates :postcode, :address, presence: true
  validates :postcode, length: {is: 7}, numericality: { only_integer: true }

  validates :post_code, presence: true
  validates :address, presence: true
  validates :address_name, presence: true

  validates :total_payment, presence: true
  validates :payment_method, presence: true


  enum payment_method:{ credit_card: 0, transfer: 1 }
  enum status: { waiting_deposit: 0, confirm_deposit: 1, in_production: 2, ready_ship: 3, complete_ship: 4 }

end
