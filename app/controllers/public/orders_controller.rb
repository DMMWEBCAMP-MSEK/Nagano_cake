class Public::OrdersController < ApplicationController

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def show
    @order=current_customer.orders.find(params[:id])
  end

  def order_confirm
  end

  def thanks
  end

end
