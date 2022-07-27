class ShippingAddress < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  VALID_POSTAL_CODE_REGEX = /\A\d{7}\z/
  validates :post_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :address, presence: true

  def postcode_and_address
    "〒" + self.post_code + " " + self.address.to_s
  end
end
