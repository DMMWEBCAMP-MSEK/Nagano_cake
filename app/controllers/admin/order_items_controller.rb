class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_items = @order.order_items.all
    if @order_item.update(order_item_params)
      if order_item_params[:production_status] == "in_production"
        @order_item.order.update(status:2)
      elsif @order_items.count == @order_items.where(production_status: "production_completed").count
        @order_item.order.update(status:3)
      end
      redirect_to admin_order_path(@order_item.order_id)
    end
  end


 private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
