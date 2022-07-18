class Item < ApplicationRecord
  belongs_to :genre
  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image

  def with_tax_price
    (price * 1.1).floor
  end

end
