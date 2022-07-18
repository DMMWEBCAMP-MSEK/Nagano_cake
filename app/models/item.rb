class Item < ApplicationRecord
  belongs_to :genre
  attachment :image

  validates :genre_id, :name, :price, presence: true
  validates :price, numericality: { only_integer: true }

  enum prdoction_status: { 販売中: true, 販売停止中: false }

  def add_tax_price
    (self.price * 1.1)
    # selfにproductを代入
  end

  # 検索機能使う場合
  def search
  end

end
