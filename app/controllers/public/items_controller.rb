class Public::ItemsController < ApplicationController

  def index
   @items = Item.all
   #@items = Item.all.page(params[:page]).reverse_order
   @genres = Genre.all
   @items_count = Item.count
  end

  def show
   @item = Item.find(params[:id])
   @genres = Genre.all
   @cart_item = CartItem.new
  end

end
