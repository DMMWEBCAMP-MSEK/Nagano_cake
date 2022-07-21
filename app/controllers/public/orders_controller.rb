class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses.all
  end

  def create
    @order = Order.new(address_params)
    @addresses = current_customer.shipping_addresses.all
    @cart_items = current_customer.cart_items.all
    if @order.save
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.item_id = cart_item.item_id
        order_item.order_id = @order.id
        order_item.amount = cart_item.amount
        order_item.price = cart_item.item.price
        order_item.save
      end
      cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      @order = Order.new(address_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
    elsif params[:order][:address_number] == "2"
      ship = ShippingAddress.find(params[:order][:customer_id])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name
    elsif params[:order][:address_number] == "3"
      #address_new = current_customer.addresses.new(address_params)
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render :new
    end

    @cart_items = current_customer.cart_items.all
    @total =  @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal + 800 }
    @cost = 800

  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :customer_id, :shipping_cost )
  end

  def address_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :customer_id, :shipping_cost, :address_number )
  end

end
