class Public::ItemsController < ApplicationController

def index
   @items = Item.all.page(params[:page]).reverse_order
   @genres = Genre.all
end

def show
   @item = Item.find(params[:id])
   @genres = Genre.all
   @cart_item = CartItem.new
end

end
