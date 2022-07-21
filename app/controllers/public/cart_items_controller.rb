class Public::CartItemsController < ApplicationController

  #before_action :set_line_item, only: [:add_item, :destroy]
  #before_action :set_customer
  #before_action :set_cart_item

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @item = Item
    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to request.referer, notice: '数量を変更してください'
    end
  end

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
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
    params.require(:cart_item).permit(:item_id, :amount, :image)
  end
end
