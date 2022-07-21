class Public::CartItemsController < ApplicationController

  #before_action :set_line_item, only: [:add_item, :destroy]
  #before_action :set_customer
  #before_action :set_cart_item

  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #@cart_item.save
    #redirect_to cart_items_path

    @cart_items = current_customer.cart_items.new(cart_item_params)

    if    current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
          cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
          cart_item.amount += params[:cart_item][:amount].to_i
          @cart_item.save
          redirect_to cart_items_path(@cart_items)
    elsif @cart_item.save
          @cart_items = current_customer.cart_items.all
          render 'orders/new'
    else
          render 'orders/new'
    end

  end

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order = Order.new
    @cart_items = current_customer.cart_items.all
  end

  def update
    #@cart_item = CartItem.find(params[:id])
    #@cart_item.update(cart_item_params)
    if my_cart_item.update_item(item_id: params[:item_id], amount: params[:amount])
    redirect_to cart_items_path
    else
    redirect_to cart_items_path
    end

  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :amount)
  end
end