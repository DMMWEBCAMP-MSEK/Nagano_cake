class Item < ApplicationRecord

  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image

end
