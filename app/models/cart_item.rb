class CartItem < ApplicationRecord

  has_one_attached :image
  belongs_to :item
  belongs_to :customer

  validates :amount, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :customer_id, :item_id, :amount, presence: true

  def subtotal
    item.with_tax_price * amount
  end

  def update_item(item_id:, amount:)
    cart_items.find_by(item_id: item_id).update(amount: amount.to_i)
  end

end
