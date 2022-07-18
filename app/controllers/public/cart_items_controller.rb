class Public::CartItemsController < ApplicationController

  def destroy_all
  end

  def index
    @cart_items= current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

end
