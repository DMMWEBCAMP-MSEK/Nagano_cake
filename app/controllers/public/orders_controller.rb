class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = current_customer.shipping_addresses.all
    #@addresses = @customer.shipping_addresses.all
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
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
    elsif params[:order][:address_number] == "2"
      ship = ShippingAddress.find(params[:order][:customer_id])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name
    elsif params[:order][:address_number] == "3"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal + 800 }
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
