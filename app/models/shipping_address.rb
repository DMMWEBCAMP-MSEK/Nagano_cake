class ShippingAddress < ApplicationRecord
<<<<<<< HEAD

  belongs_to :customer

  def address_display
  '〒' + post_code + ' ' + address + ' ' + name
  end

=======
  belongs_to :customer
>>>>>>> 682c17ff296cc00baf9ff60f6b4c7ca931cf4ecc
end
