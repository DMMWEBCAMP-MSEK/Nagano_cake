class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = current_customer.shipping_addresses.all
  end

  def index
    @orders = current_customer.orders.page(params[:page])

  end

  def show

  end

  def create
    @order = current_customer.orders.new(order_params)
    @addresses = current_customer.shipping_addresses.all
    @cart_items = current_customer.cart_items.all
      if @order.save
      @cart_items.each do |cart_item|
      @order_item = @order.order_items.new
      @order_item.item_id = cart_item.item.id
      @order_item.amount = cart_item.amount
      @order_item.price = cart_item.item.price
      @order_item.save
        end
      redirect_to thanks_orders_path
      @cart_items.destroy_all
      else
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
    @cost = 800
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :post_code, :payment_method, :total_payment, :shipping_cost)
  end

  def address_params
  params.require(:order).permit(:name, :address, :post_code)
  end

end
