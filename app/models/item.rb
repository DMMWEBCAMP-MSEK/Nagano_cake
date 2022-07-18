class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  
  has_one_attached :image

<<<<<<< HEAD
  validates :genre_id, :name, :price, presence: true
  validates :price, numericality: { only_integer: true }

  enum prdoction_status: { 販売中: true, 販売停止中: false }

  def add_tax_price
    (self.price * 1.1).floor
    # selfにproductを代入
  end

  # 検索機能使う場合
  def search
  end
=======
  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image
>>>>>>> develop

end
