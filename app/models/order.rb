class Order < ApplicationRecord

  has_many :order_items
  belongs_to :customer

  with_options presence: true do
     validates :payment_method
     validates :post_code, length: { is: 7 }
     validates :address
     validates :name
     validates :total_payment
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {
     waiting_for_payment: 0,
     payment_confirmation: 1,
     in_production: 2,
     preparing_to_ship: 3,
     shipped: 4
  }

  def items_amount
    array = []
    order_items.all.each do |order_item|
      array << order_item.amount
    end
    array.sum
  end

  def order_price
    array = []
    order_items.all.each do |order_item|
      array << order_item.amount*order_item.price
    end
    array.sum.to_s(:delimited)
  end

  def cart_items_price
    array = []
    cart_items.all.each do |cart_item|
      array << cart_item.amount*cart_item.price
    end
    array.sum.sum.to_s(:delimited)
  end


  def postcode_and_address
    self.post_code + '(' + self.address.to_s + ')'
  end

end
