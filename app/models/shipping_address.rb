class ShippingAddress < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  validates :post_code, presence: true, format: {with: /\A\d{7}\z/, message: "ハイフンなしの７桁で入力して下さい"}
  validates :address, presence: true

  def postcode_and_address
    "〒" + self.post_code + " " + self.address.to_s
  end
end
