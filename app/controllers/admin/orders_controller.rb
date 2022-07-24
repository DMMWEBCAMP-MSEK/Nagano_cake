class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    @order = Order.find(params[:id])
    #production_status_change_to_1 = @order.status_was == "waiting_for_payment" and @order.status == "payment_confirmation"
    if @order.update(order_params)
      # if production_status_change_to_1
      #   @order.order_items.update_all(production_status: 1)
      # end
      if order_params[:status] == "payment_confirmation"
        @order.order_items.update_all(production_status:1)
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
