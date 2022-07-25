class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def index
    @orders = Order.page(params[:page])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
    redirect_to admin_order_path(@order_item.order_id)
    else
    render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end


end
