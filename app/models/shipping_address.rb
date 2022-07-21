class ShippingAddress < ApplicationRecord
  belongs_to :customer

  def postcode_and_address
    "〒" + self.post_code + " " + self.address.to_s
  end
end
