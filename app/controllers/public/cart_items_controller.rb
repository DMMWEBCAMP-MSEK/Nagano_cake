class Public::CartItemsController < ApplicationController

  def destroy_all
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)

  end

  def index
    @cart_items= current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
