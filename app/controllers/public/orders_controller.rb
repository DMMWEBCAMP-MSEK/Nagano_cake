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
    @cart_items = current_customer.cart_items.all
    @shipping_address = current_customer.shipping_addresses.new(address_params)
    if @order.save
      @cart_items.each do |cart_item|
        @order_item = @order.order_items.new
        @order_item.item_id = cart_item.item.id
        @order_item.amount = cart_item.amount
        @order_item.price = cart_item.item.price
        @order_item.save
      end
      if params[:order][:address_number] == "3"
      @shipping_address.save
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
    #@order.name = current_customer.last_name + current_customer.first_name
    @order.name = current_customer.first_name + current_customer.last_name
    @order.address = current_customer.address
    @order.post_code = current_customer.post_code
    elsif params[:order][:address_number] == "2"

        if    params[:order][:customer_id] == ""
              flash[:notice] = "お届け先の登録済住所を選択してください"
              redirect_to new_order_path
        else

      ship = ShippingAddress.find(params[:order][:customer_id])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name
        end

    elsif params[:order][:address_number] == "3"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

        if    params[:order][:post_code] == "" || params[:order][:address] == "" || params[:order][:name] == ""
              flash[:notice] = "新しいお届け先を全て入力してください"
              redirect_to new_order_path
        else
            　@order.post_code = params[:order][:post_code]
            　@order.address = params[:order][:address]
            　@order.name = params[:order][:name]
        end

    else
      redirect_to new_order_path
      flash[:notice] = "お届け先のボタンを押してください"
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @cart_items.inject(800) { |sum, item| sum + item.subtotal}
    @order.shipping_cost = 800
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :shipping_cost)
  end

  # def order_item_params
  #   params.require(:order_item).permit(:item_id, :order_id, :amount, :price)
  # end

  def address_params
  params.require(:order).permit(:name, :address, :post_code, :customer_id)
  end

  # def shipping_address_params
  #   params.require(:shipping_address).permit(:post_code, :address, :name)
  # end
end