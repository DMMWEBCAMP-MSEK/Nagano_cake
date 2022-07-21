class Order < ApplicationRecord

  has_many :order_items
  belongs_to :customer

  with_options presence: true do
     validates :payment_method
     validates :address
     validates :name
   end
  
  enum status: {
     "入金待ち":0, 
     "入金確認":1, 
     "製作中":2, 
     "発送準備中":3, 
     "発送済み":4
  }
  
  enum payment_method: ["クレジットカード", "銀行振込"]

  def postcode_and_address
    self.post_code + '(' + self.address.to_s + ')'
   end

end
