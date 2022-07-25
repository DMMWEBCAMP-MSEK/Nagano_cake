class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]

  def index
    #@items = Item.all.page(params[:page]).reverse_order
    @items = Item.where(sales_status: 0).page(params[:page]).reverse_order.per(8)
    @genres = Genre.all
    @items_count = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

 private
# def item_params
#   params.require(:items).permit(:genre_id,:name,:image_id,:price)
# end
end
