class ShippingAddress < ApplicationRecord

  belongs_to :customer

  def address_display
  '〒' + post_code + ' ' + address + ' ' + name
  end

  def postcode_and_address

"〒" + self.post_code + " " + self.address.to_s

  end

end
