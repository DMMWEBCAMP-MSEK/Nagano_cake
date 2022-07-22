class Order < ApplicationRecord

  has_many :order_items
  belongs_to :customer

  with_options presence: true do
     validates :payment_method
     validates :address
     validates :name
     validates :total_payment
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {
     "入金待ち":0,
     "入金確認":1,
     "製作中":2,
     "発送準備中":3,
     "発送済み":4
  }
  #enum status: { waiting_deposit: 0, confirm_deposit: 1, in_production: 2, ready_ship: 3, complete_ship: 4 }

  validates :post_code, presence: true
  validates :address, presence: true
  validates :address_name, presence: true
  validates :post_code, length: {is: 7}, numericality: { only_integer: true }

  def postcode_and_address
    self.post_code + '(' + self.address.to_s + ')'
  end

end
