class Item < ApplicationRecord


  enum sales_status: { sale: 0, stop_selling: 1 }
  attachment :image_id


end
