class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    @order = Order.find(params[:id])
    # 入金状態になったら全て製作待ちに
    if @order.update(order_params)
      if order_params[:status] == "confirm_deposit"
        @order.order_items.update_all(production_status: 1)
      end
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def order_item_params
    params.require(:order_item).permit(:price)
  end
end
