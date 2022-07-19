class Public::ShippingAddressesController < ApplicationController

  def index
    @shipping_address = ShippingAaddress.new
    @shipping_addresses = ShippingAddress.all
  end

  def edit
    @shipping_address = Shipping_address.find(params[:id])
  end

  def update
    @shipping_address = Shipping_address.find(params[:id])
    if @shipping_address.update
      redirect_to shipping_addresses_pass
    end
  end

end
