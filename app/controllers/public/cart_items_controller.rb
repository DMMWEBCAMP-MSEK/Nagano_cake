class Public::CartItemsController < ApplicationController

  #before_action :set_line_item, only: [:add_item, :destroy]
  #before_action :set_customer
  #before_action :set_cart_item

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @item = Item.find(params[:id])
    #@cart_item.customer_id = current_customer.id
    @cart_item = current_customer.cart_item.build(item_id: params[:item_id])
    @cart_item.save
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items.includes([:item])
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def destroy_all
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end