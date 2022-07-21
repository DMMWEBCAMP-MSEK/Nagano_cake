class Admin::OrderItemsController < ApplicationController

  before_action :authenticate_admin!
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    if @order_item.update(order_item_params)
      # 製作ステータスが製作中になったら注文ステータスも製作中へ
      if order_item_params[:production_status] == "in_production"
        @order.update(status: 2)
      # 製作ステータスが製作完了になったら注文ステータスを発送準備中へ
      elsif @order.order_items.all? {|order_item| order_item.production_status == "complete_production"}
        @order.update(status: 3)
      end
        redirect_to admin_order_path(@order)
    end
  end

  private
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
