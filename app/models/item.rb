class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  enum sales_status: { sale: 0, stop_selling: 1 }
  has_one_attached :image

  validates :genre_id, :name, :price, presence: true
  validates :price, numericality: { only_integer: true }

  def with_tax_price
    (price * 1.1).floor
  end

  ## 検索機能使う場合
  def search
  end
end
