class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

  def subtotal
    item.with_tax_price * amount
  end

  def change
    create_table :cart_items do |t|
      t.integer :amount, default: 0
      t.integer :item, null: false, foreign_key: true
      t.timestamps
    end
  end

end
