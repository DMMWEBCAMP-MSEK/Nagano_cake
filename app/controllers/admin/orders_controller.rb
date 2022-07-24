class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      production_status_change_to_1 = @order.status_was == 0 and @order.status == 1
      if production_status_change_to_1
        @order.production_status.update_all(production_status: 1)
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
end
