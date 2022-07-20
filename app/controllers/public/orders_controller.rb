class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.shipping_addresses.all
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
      if @order.save
      cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item_id
      order_item.order_id = @order.id
      order_item.order_amount = cart_item.amount
      order_item.order_price = cart_item.price
      order_item.save
        end
      redirect_to confirm_orders_path
      cart_items.destroy_all
      else
      @order = Order.new(order_params)
      render :new
      end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
    @order.name = current_customer.last_name
    @order.address = current_customer.address
    @order.post_code = current_customer.post_code
    elsif params[:order][:address_number] == "2"

      if ShippingAddress.exists?(name: params[:order][:registered])
      @order.name = ShippingAddress.find(params[:order][:registered]).name
      @order.address = ShippingAddress.find(params[:order][:registered]).address
      @order.post_code = ShippingAddress.find(params[:order][:registered]).post_code
      else
      render :new
      end

    elsif params[:order][:address_number] == "3"
    address_new = current_customer.address.new(address_params)

      if address_new.save

      else
      render :new
      end

    else
      redirect_to new_order_path
    end

    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @cost = 800

  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_price)
  end

  def address_params
  params.require(:order).permit(:name, :address, :post_code)
  end

end
