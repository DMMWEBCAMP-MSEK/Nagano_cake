class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]

def index
   @selling_items = Item.where(sales_status:"sale").page(params[:page]).reverse_order.per(8)
   @genres = Genre.all
   @items_count = Item.where(sales_status:"sale").count
end

def show
   @item = Item.find(params[:id])
   @genres = Genre.all
   @cart_item = CartItem.new
end

private
# def item_params
#   params.require(:items).permit(:genre_id,:name,:image_id,:price,:introduction)
# end
end
