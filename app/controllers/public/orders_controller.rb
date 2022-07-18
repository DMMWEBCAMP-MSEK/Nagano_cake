class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
  end

  def show
  end



  def order_confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.post_code = current_customer.post_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    render action: "order_confirm"
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name)
  end

  def address_params
  params.require(:order).permit(:name, :address)
  end

end
